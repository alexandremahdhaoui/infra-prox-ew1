# dns_api_server

We would like to register new vms to the DNS as soon as they're up & running. 
To randomly assign any IPs to new vms/container or use DHCP.

The goal of this project is to achieve **decentralized server-side service discovery**.

Issues: 
- How do we unregister vms/containers that might shut down in a non-gracefully manner?
  - Use health checks.
  - Try to terminate non-healthy vms/containers.
  - Then unregister them from the DNS.

# Repository structure

| Path | Description |
|------|-------------|
|      |             |
|      |             |

# TODO: Next steps
- Persistence: implement function to save the `dnsfile`.
- Putting it all together: have both the `coredns` thread & server running.
- Write tests.

# Getting started

This binary will create a REST API server to {create,read,update,delete} records for the nameserver.

| Endpoint | Method | Description                 |
|----------|--------|-----------------------------|
| /a       | GET    | get all A records.          |
| /a/:name | GET    | get one A record by name.   |
| /a       | POST   | create a new A record.      |
| /a/:name | PUT    | update an A record by name. |
| /a/:name | DELETE | delete an A record by name. |
|          |        |                             |

At the beginning we will use this as a monorepo. And will contain other business logic:
- Spawn a `coredns` process.
- Listen to change on `dns_file`.
  - https://docs.rs/notify/latest/notify/
  - https://docs.rs/notify/4.0.15/notify/enum.DebouncedEvent.html 
- When change happen, restart `coredns` process.


# Considerations

We will have a problem when we will try to authenticate/authorize clients.
Indeed, we'll maybe try to use JWT tokens to authenticate new VM/container trying to register to the DNS. 