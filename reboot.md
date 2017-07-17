sysctl -w kernel.panic=10
echo 1 > /proc/sys/kernel/sysrq
echo c > /proc/sysrq-trigger 
