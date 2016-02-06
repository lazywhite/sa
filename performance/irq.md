中断
    软件中断
        Software Interrupts  /proc/stat

        These interrupts are generated when the CPU executes an instruction which can cause an exception condition in the CPU [ALU unit] itself.

        For example, divide a number by zero which is not possible, it will lead to divide-by-zero exception, causing the computer to abandon the calculation or display an error message.


    硬件中断
        NMI: non-maskable interrupt(memory error, temprature sensor failure)
        MI: maskable interrupt

## 中断绑定
### stop irq auto balancer
/etc/init.d/irqbalance stop
### get irq sn of device
```
cat /proc/interrupts
           CPU0   CPU1  CPU2  CPU3
  0: 3710374484      0     0     0  IO-APIC-edge  timer
  1:         20      0     0     0  IO-APIC-edge  i8042
  6:          5      0     0     0  IO-APIC-edge  floppy
  7:          0      0     0     0  IO-APIC-edge  parport0
  8:          0      0     0     0  IO-APIC-edge  rtc
  9:          0      0     0     0  IO-APIC-level  acpi
 12:        240      0     0     0  IO-APIC-edge  i8042
 14:   11200026      0     0     0  IO-APIC-edge  ide0
 51:   61281329      0     0     0  IO-APIC-level  ioc0
 59:          1      0     0     0  IO-APIC-level  vmci
 67:   19386473      0     0     0  IO-APIC-level  eth0
 75:   94595340      0     0     0  IO-APIC-level  eth1
NMI:          0      0     0     0
LOC: 3737150067 3737142382 3737145101 3737144204
ERR:          0
MIS:          0

1. The first Column is the IRQ number.
2. The Second column says how many times the CPU core has been interrupted. 
3. For interrupt like rtc [Real time clock] CPU has not being interrupted. RTC are present in electronic devices to keep track of time.
4. NMI and LOC are drivers used on system that are not accessible/configured by user
5. A small IRQ number value means higher priority.

IRQ 0 — system timer (cannot be changed);
IRQ 1 — keyboard controller (cannot be changed)

``` 
### set smp_affinity

```
echo '2' > /proc/irq/67/smp_affinity 
'5' 为平衡到cpu1, cpu2 上

　　　　　Binary　　　　Hex
CPU 0　　00000001　　　　1
CPU 1　　00000010　　　　2
CPU 2　　00000100　　　　4
CPU 3　　00001000　　　　8
```

### 常用
数据库服务器将磁盘控制器与网卡中断绑定到不同cpu来提升性能


