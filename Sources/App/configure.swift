import Vapor
import Fluent
import Leaf
import FluentPostgresDriver

/// Called before your application initializes.
public func configure(_ app: Application) throws {
    // Register providers first
//    try services.register(LeafProvider())
//    // Use Leaf for rendering views
//    config.prefer(LeafRenderer.self, for: ViewRenderer.self)


    // Register middleware
    app.middleware.use(ErrorMiddleware.default(environment: app.environment))
    app.middleware.use(FileMiddleware.init(publicDirectory: app.directory.publicDirectory))
    // Use Leaf for rendering views
    app.views.use(.leaf)
    
    
    // Register routes to the router
    try routes(app)
//    let router = EngineRouter.default()
//    try routes(router)
//    services.register(router, as: Router.self)
    

    
    // Register Database
    let dburl:String = ProcessInfo.processInfo.environment["DATABASE_URL"] ?? "postgres://postgres@localhost/postgres"
    try app.databases.use(.postgres(url: dburl), as: .psql)
//    try services.register(FluentPostgreSQLProvider())
//
//    let dburl:String = ProcessInfo.processInfo.environment["DATABASE_URL"] ?? ""
//
//    if !(dburl .isEmpty) {
//        let postgresqlConfig:PostgreSQLDatabaseConfig = PostgreSQLDatabaseConfig(url: dburl)! //
//        services.register(postgresqlConfig)
//    }
    
    
    // Migration for Database has to be done by hand
    
//    var migrations = MigrationConfig()
//    migrations.add(model: TeamMateDbModel.self, database: .psql)
//    migrations.add(model: Track.self, database: .psql)
//    migrations.add(model: ParkingLotTopic.self, database: .psql)
//    services.register(migrations)
    
    // Extend the body size of Swift NIO from 1Mb to 7Mb
//    services.register(NIOServerConfig.default(maxBodySize: 7_000_000, supportCompression: false))
}
