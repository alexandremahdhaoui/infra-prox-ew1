use std::process::{Child, Command};

const COREDNS_BIN: &str = "coredns";

// coredns::spawn will spawn a new Child process running `COREDNS_BIN` and returns it
pub(crate) fn spawn() -> Child {
    // Start a process (the "sleep" command in this case, which just waits for a specified amount of time)
    Command::new(COREDNS_BIN)
        // Start the process and capture the `Child` struct
        .spawn()
        .expect("failed to start process")
}
