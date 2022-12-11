mod dns_zonefile_parser;
mod coredns_controller;
mod server;

#[macro_use] extern crate rocket;


#[launch]
fn rocket() -> _ {
    server::server::mount()
}
