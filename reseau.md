* [tunnel gre sur Debian](#tunnel-gre-sur-Debian)

## tunnel gre sur Debian
auto gre0
        iface gre0 inet static
        address 10.10.2.20/24  # extremité interne local du tunnel
        pre-up ip tunnel add gre0 mode gre remote 164.172.213.191 local 166.172.117.10 # extremité externe local et distance du tunnel
        pre-up ip link set gre0 multicast on
        post-down ip tunnel del gre1
