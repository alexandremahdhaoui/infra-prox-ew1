# Networking

## Towards a more scalable virtual network?

Add virtual bridge without the loss of networking?:
`With KVM (but not Xen) you can now use Macvtap instead of bridging. So you don't actually have to tear down the host's network stack and bring it back up with a bridge. Macvtap works by piggybacking on an existing ethernet interface. It will make your ethernet interface listen on an additional MAC address and it will "steal" the incoming packets addresses to that MAC address so they don't appear to enter through that ethernet interface anymore and instead go to the guest.`:

Ref: https://unix.stackexchange.com/questions/198642/add-virtual-bridge-without-the-loss-of-networking

## SDN

With software defined network plugins we can easily configure networking resources.