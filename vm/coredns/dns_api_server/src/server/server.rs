use rocket::{Build, Rocket};
use crate::server::a_record::{get_a, get_a_by_name, create_a, update_a, delete_a};

const A_RECORD_ROUTE: &str = "/a";

pub(crate) fn mount() -> Rocket<Build> {
    rocket::build()
        // A Records
        .mount(A_RECORD_ROUTE, routes![get_a])
        .mount(A_RECORD_ROUTE, routes![get_a_by_name])
        .mount(A_RECORD_ROUTE, routes![create_a])
        .mount(A_RECORD_ROUTE, routes![update_a])
        .mount(A_RECORD_ROUTE, routes![delete_a])
}
