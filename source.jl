using Distributions
using Random

num_car_in_system=0 
clock=0.0
t_car_arrival=0
t_car_departure=0 
num_car_arrivals=0
num_car_departure=0
total_wait=0.0 
wait_pump=0.0
wait_attendant=0.0
busy_pump=0
busy_attendant=0
service_time=0.0
inter_arrival_time=0.0
failling_time=0.0
total_record_pump=Float64[]
total_record_attendant=Float64[]
total_record_failling=Float64[]

while true
    record_pump=0.0
    record_attendant=0.0
    record_failling=0.0
    inter_arrival_time=rand(Exponential(1))
    service_time=rand(Exponential(.5))
    t_car_arrival=inter_arrival_time
    t_car_departure=Inf
    t_event=min(t_car_arrival , t_car_departure)
    if (busy_pump!=0)
        x=0
        y=service_time
        num_car_arrivals+=1
        z=inter_arrival_time
        while x<y && x<z
            wait_pump+=service_time
            record_pump+=service_time
            push!(total_record_pump,record_pump)
            num_car_arrivals+=1
            x+=1
        end
        busy_pump=0
    else
        if (busy_attendant!=0)
            x=0
            y=service_time
            z=inter_arrival_time
            while x<y &&x<z
                wait_attendant+=service_time
                record_attendant+=service_time
                push!(total_record_attendant,record_attendant)
                num_car_arrivals+=1
                x+=1
            end
            busy_attendant=0
            num_car_departure+=1
        else
            num_car_departure+=1
            busy_pump=1
            busy_attendant=1
            x=service_time
            wait_attendant+=x
            record_attendant+=x
            push!(total_record_attendant,record_attendant)
            failling_time+=x
            record_failling+=x
            push!(total_record_failling,record_failling)
            while x >=0
                x-=1
            end
            t_car_departure=clock+service_time
            t_car_arrival=clock+inter_arrival_time
        end
    end
    clock+=1
    if (clock>=100)
        break
    end
end
println("The total wait : ")
total_wait=wait_pump+wait_attendant+failling_time
println("The number car arrivals : ")
num_car_arrivals
println("The number car departure : ")
num_car_departure
println("The total wait of pump : ")
wait_pump
println("The Total wait of attendant : ")
wait_attendant
println("The total failling time : ")
failling_time
println("record wait pump cars : ")
total_record_pump
println("record wait attendant cars : ")
total_record_attendant
println("record failling time of cars : ")
total_record_failling
#if the code have error.please take the code copy and paste in julia ...not run automatically.thanks