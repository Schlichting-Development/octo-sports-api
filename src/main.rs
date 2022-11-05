use actix_web::{HttpServer, App, get, Responder, HttpResponse};
use anyhow::Result;
use log::{info};

#[tokio::main]
async fn main() -> Result<()> {
    env_logger::init();
    info!("Application starting up...");
    HttpServer::new(|| {
        App::new()
            .service(hello_world)
    })
    .bind(("0.0.0.0", 8080))?
    .run()
    .await?;
    return Ok(());
}


#[get("/")]
async fn hello_world() -> impl Responder {
    return HttpResponse::Ok().body("hello world");
}
