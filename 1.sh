while [ 1=1 ]
do  
    
    for i in 192.168.0.1 173.194.222.113 87.250.250.242
    do 
        for ((j=0;j < 5;j++))
        do
        curl http://$i
            
        if [ $? != 0 ]
            then
                date >> curl.log
                echo ERROR $i  >> curl.log
                exit
            fi
        sleep 1
        done
    done
    sleep 20
done
    
