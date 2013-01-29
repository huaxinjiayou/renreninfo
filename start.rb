# coding: utf-8

require_relative 'work'

email, password, start_id, end_id = ARGV
if(!email || !password)
    puts "email and password are necessary"
    return
end

START_ID = 0
END_ID = 1000000000

start_id = START_ID unless start_id
end_id = END_ID unless end_id

# TODO: whether both start_id and end_id can convert to integer

start_id, end_id = end_id.to_i, start_id.to_i if start_id.to_i > end_id.to_i

worker = Worker.new(email, password, start_id, end_id)

# Thread.start do
    worker.work()
# end

# system "stty cbreak -echo"
# begin
#    loop do
#        if STDIN.getc == ?q
#            worker.stop = true
#            sleep(20)
#            break
#        end
#    end
# end
# system "stty cooked echo"
