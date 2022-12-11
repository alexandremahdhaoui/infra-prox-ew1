use crate::dns_zonefile_parser::record::{Record, RecordData};
use rocket::serde::{json::Json};
use crate::dns_zonefile_parser::record;
use crate::dns_zonefile_parser::zonefile::ZonefileBuilder;

// | /a       | GET    | get all A records.          |
// | /a/:name | GET    | get one A record by name.   |
// | /a       | POST   | create a new A record.      |
// | /a/:name | PUT    | update an A record by name. |
// | /a/:name | DELETE | delete an A record by name. |

const ZONEFILE_PATH: &str = "./dnsfile";

#[get("/")]
pub(crate) fn get_a() -> &'static str {
    "/a"
}

#[get("/<name>")]
pub(crate) fn get_a_by_name(name: &str) -> String {
    format!("/a/{}", name)
}

// curl -XPOST 127.0.0.1:8000/a --data '{"name": "yolo.com.", "class": "IN", "record_type": "A", "value": "127.0.0.1"}'
#[post("/", data = "<record>")]
pub(crate) fn create_a(record: Json<Record>) -> String {
    let builder= &mut ZonefileBuilder::from_path(ZONEFILE_PATH).unwrap();
    let record_data = RecordData::A(Record::from_json(record));
    builder.add_record(record_data);
    builder.build().to_string()
}

// curl -XPUT 127.0.0.1:8000/a/test.mahdhaoui.com. --data '{"name": "test.mahdhaoui.com.", "class": "IN", "record_type": "A", "value": "10.0.0.1"}'
#[put("/<name>", data = "<record>")]
pub(crate) fn update_a(name: &str, record: Json<Record>) -> String {
    let builder= &mut ZonefileBuilder::from_path(ZONEFILE_PATH).unwrap();
    let record_data = RecordData::A(Record::from_json(record));
    builder.update_record(name, record_data);
    builder.build().to_string()
}

// curl -XDELETE 127.0.0.1:8000/a/test.mahdhaoui.com.
#[delete("/<name>")]
pub(crate) fn delete_a(name: &str) -> Result<String, String> {
    let builder= &mut ZonefileBuilder::from_path(ZONEFILE_PATH).unwrap();
    builder.delete_record(name, record::A);
    Ok(builder.build().to_string())
}