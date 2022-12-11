use std::path::Path;
use notify::{Event, recommended_watcher, RecommendedWatcher, RecursiveMode, Watcher};
use std::sync::mpsc::{channel, Receiver};
use notify::EventKind::Modify;

const FILE_DNS_PATH: &str = "./dns_file";
const COREFILE_PATH: &str = "./corefile";

// Create a watcher to watch `FILE_DNS_PATH`
pub(crate) fn file_watcher() -> Event {
    let (tx, rx) = channel();

    // Create a watcher to watch the current directory
    let mut watcher = recommended_watcher(tx)
        .expect("failed to create watcher");
    watch_path(&mut watcher, FILE_DNS_PATH);
    watch_path(&mut watcher, COREFILE_PATH);

    await_event(rx)
}

fn watch_path(watcher: &mut RecommendedWatcher, path: &str) {
    let path = Path::new(path);
    watcher
        .watch(path, RecursiveMode::NonRecursive)
        .expect("failed to watch directory");
}

// await_event takes a rx as input, loop until it receives an event.
// WARN: in the future please change this logic. This can lead to missing events in case
fn await_event(rx: Receiver<Result<Event, notify::Error>>) -> Event {
    // Loop indefinitely, waiting for notifications
    loop {
        match rx.recv() {
            Ok(event) => {
                match event {
                    Ok(event) => {
                        if let Modify(_) = event.kind { return event }
                    },
                    Err(e) => println!("error: {:?}", e)
                }
            }
            Err(e) => println!("error: {:?}", e)
        }
    }
}