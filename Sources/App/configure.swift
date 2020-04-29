import Leaf
import Vapor
import FluentPostgreSQL
import PostgreSQL

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(LeafProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    // Use Leaf for rendering views
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)
    
    // Register Database
    try services.register(FluentPostgreSQLProvider())
    
    let dburl:String = ProcessInfo.processInfo.environment["DATABASE_URL"] ?? ""
    
    if !(dburl .isEmpty) {
        let postgresqlConfig:PostgreSQLDatabaseConfig = PostgreSQLDatabaseConfig(url: dburl)! //
        services.register(postgresqlConfig)
    }
    
    
    // Migration for Database
    var migrations = MigrationConfig()
    migrations.add(model: TeamMateDbModel.self, database: .psql)
    migrations.add(model: Track.self, database: .psql)
    migrations.add(model: ParkingLotTopic.self, database: .psql)
    services.register(migrations)
    
    // Extend the body size of Swift NIO from 1Mb to 2Mb
    services.register(NIOServerConfig.default(maxBodySize: 2_000_000, supportCompression: false))
}
