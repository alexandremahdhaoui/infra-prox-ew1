use std::collections::HashMap;
use std::error::Error;

// We'll use the reqwest library to make HTTP requests
use reqwest;

// Define the URL to the Proxmox API
const PROXMOX_API_URL: &str = "https://your.proxmox.server/api2/json";

// Define the structure for storing Proxmox API credentials
struct Credentials {
    user: String,
    password: String,
}

// Define the structure for storing Proxmox API responses
struct ProxmoxResponse {
    success: bool,
    data: HashMap<String, String>,
}

// Define a function for making requests to the Proxmox API
fn proxmox_request(
    credentials: &Credentials,
    path: &str,
    params: &HashMap<String, String>,
) -> Result<ProxmoxResponse, Box<dyn Error>> {
    // Build the full URL by concatenating the base URL with the path and parameters
    let mut url = format!("{}/{}", PROXMOX_API_URL, path);
    if !params.is_empty() {
        url += "?";
        for (key, value) in params {
            url += &format!("{}={}&", key, value);
        }
    }

    // Make the HTTP request to the Proxmox API
    let response = reqwest::Client::new()
        .get(&url)
        .basic_auth(&credentials.user, Some(&credentials.password))
        .send()?
        .json()?;

    // Parse the response and return it
    let success = response["success"].as_bool().unwrap_or(false);
    let data = response["data"].as_object().unwrap_or_default();
    Ok(ProxmoxResponse { success, data })
}
