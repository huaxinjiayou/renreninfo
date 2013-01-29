# coding: utf-8

require_relative 'renren'
require_relative 'cache'
require_relative 'mysql'

class Worker
    attr_accessor :stop

    def initialize(email, pwd, start_id, end_id)
        @renren, @cache, @sql = RenRen.new(email, pwd), Cache.new, RenRenMysql.new
        @start_id, @end_id = start_id, end_id

        # go to die
        @stop = false;
    end

    def work
        @renren.login()

        id = @start_id
        while id < @end_id
            format_put("save info about #{id}")
            save_info(id) rescue log(id)
            id += 1

            # break if @stop
        end

        # if @stop
        #     format_put("break in id #{id}")
        # else
            format_put("END")
        # end
    end

    private
    def save_info(id)
        friends = @renren.get_friendship(id)['candidate']
        return unless friends

        friends.each do |friend|
            f_id, f_name, f_netname = friend['id'], friend['name'], friend['netName']
            @sql.save_relation(id, f_id)
            format_put("#{id} ~ #{f_id}")

            exists = @cache.exists(f_id)
            if exists && @cache.get(f_id) == '1' || !exists && !@sql.exists(f_id)
                @sql.save_user(f_id, f_name, f_netname)

                # 2 means cached and has info
                @cache.set(f_id, 2) if exists
            end
        end

        # 1 means cached but no info
        @cache.set(id, 1) if friends.length > 250
    end

    def get_friends(id)
        tries = 0
        begin
            tries += 1
            friends = @renren.getFriendShip(id)['candidate']
            rescue
            @renren.login
            format_put('has a sleep')
            if tries < 5
                sleep(2 * tries)
                retry
            else
                log(id)
                friends = nil
            end
        end
        friends
    end

    def format_put(val)
        puts "#{'-' * 20}#{val}#{'-' * 20}"
    end

    def log(id)
        File.open('fail.log', 'a') {|f| f.write("#{id}\n")}
    end
end
