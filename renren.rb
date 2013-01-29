# coding: utf-8

require 'json'
require 'mechanize'

require_relative 'encrypt'

include ENCRYPT

class RenRen
    attr_accessor :agent

    include ENCRYPT

    def initialize(email = nil, pwd = nil)
        @agent = Mechanize.new

        @email, @pwd = email, pwd
    end

    def login
        key = get_encryptkey()
        data = {
            'email' => @email,
            'origURL' => 'http://www.renren.com/home',
            'icode' => '',
            'domain' => 'renren.com',
            'key_id' => 1,
            'captcha_type' => 'web_login',
            'password' => key['isEncrypt'] ? encrypt_string(key['e'], key['n'], @pwd) : @pwd,
            'rkey' => key['rkey']
        }
        url = "http://www.renren.com/ajaxLogin/login?1=1&uniqueTimestamp=#{rand}"
        r = @agent.post(url, data, {})
        result = JSON.parse(r.body)
        if result['code']
            @agent.get(result['homeUrl'])
            puts 'login successfully'
            true
        else
            puts "login error #{r.body}"
            false
        end
    end

    def get_friendship(id = 255510050)
        url = "http://friend.renren.com/friendfriendSelector?p={%22init%22:false,%22qkey%22:%22friend%22,%22uid%22:true,%22uname%22:true,%22uhead%22:true,%22limit%22:1000,%22param%22:{%22guest%22:%22#{id}%22},%22query%22:%22%22,%22group%22:%22%22,%22net%22:%22%22}"
        r = @agent.get(url)
        result = JSON.parse(r.body)
    end

    def get_info(id)
        info = @agent.get('http://www.renren.com/#{id}/profile?v=info_ajax')
        info.body
    end

    def get_encryptkey
        r = @agent.get('http://login.renren.com/ajax/getEncryptKey')
        JSON.parse(r.body)
    end

    def get_token(html = nil)
        html = @agent.get('http://www.renren.com').body unless html

        reg = /get_check:'(.*)',get_check_x:'(.*)',env/

        html =~ reg
        result = Regexp.last_match
        @token = {
            'requestToken' => result[1],
            '_rtk' => result[2]
        }
    end

end
