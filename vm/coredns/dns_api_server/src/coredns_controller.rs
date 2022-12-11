pub(crate) mod coredns;
pub(crate) mod file_watcher;

fn coredns_controller() {
    loop {
        let mut process = coredns::spawn();
        file_watcher::file_watcher();
        process.kill().expect("failed to stop process");
    }
}