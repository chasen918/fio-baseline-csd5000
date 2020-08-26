#!/bin/bash

disks=(sfdv0n1)

pid_list=""
for disk in ${disks[@]};
do
    iostat -dxmct 1 ${disk} > ${disk}.iostat &
    fio --filename=/dev/${disk} --output=${disk}_fio.log ./baseline.fio &
    pid_list="${pid_list} $!"
done

wait ${pid_list}
pkill -9 iostat