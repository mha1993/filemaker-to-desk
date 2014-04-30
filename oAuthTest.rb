##############################################################################
##########################       DEPENDENCIES       ##########################
##############################################################################

require "rubygems"
require "oauth"
require "net/https"
require "uri"
require "json"




##############################################################################
##########################         GLOBALS          ##########################
##############################################################################

MY_SITE = "https://danceofthedeer.desk.com"
CONSUMER_KEY = "K2irbhkv0TONhgjqfGaD"
CONSUMER_SECRET = "rImMNQSo72OOvzGTY8pVx6P9sCaTmNPhz53SrheG"
ACCESS_KEY = "rNxxIDRDI5TPfkb31NTE"
ACCESS_SECRET = "m9T83lRBBi905NJreXu5zImimXqsZydMw4X6TzNU"

CUSTOMER_AP = "https://danceofthedeer.desk.com/api/v2/customers"
CASE_AP = "https://danceofthedeer.desk.com/api/v2/cases"





##############################################################################
##########################         API CALLS        ##########################
##############################################################################

# ACCESS TOKEN
def generateAccessToken()
    consumer = OAuth::Consumer.new(
        CONSUMER_KEY,
        CONSUMER_SECRET,
        :site => MY_SITE,
        :scheme => :header
    )
                                   
    access_token = OAuth::AccessToken.from_hash(
        consumer,
        :oauth_token => ACCESS_KEY,
        :oauth_token_secret => ACCESS_SECRET
    )
    
    return access_token
end


# CASES
def createCase(access_token, request)
    puts access_token.post(CASE_AP, request).body
end

def deleteCase(access_token, id)
    puts access_token.delete(CASE_AP + '/' + id).body
end

def updateCase(access_token, id, request)
    puts access_token.post(CASE_AP + '/' + id, request, {'X-HTTP-Method-Override'=>'PATCH'}).body
end

def searchCases(access_token, request)
    puts access_token.get(CASE_AP, request)
end

def getCase(access_token, id)
    puts access_token.get(CASE_AP + '/' + id).body
end


#CUSTOMERS
def createCustomer(access_token, request)
    puts access_token.post(CUSTOMER_AP, request).body
end

def updateCustomer(access_token, id, request)
    puts access_token.post(CUSTOMER_AP + '/' + id, request, {'X-HTTP-Method-Override'=>'PATCH'}).body
end

def getCustomer(access_token, id)
    puts access_token.get(CUSTOMER_AP + '/' + id).body
end





##############################################################################
##########################           MAIN           ##########################
##############################################################################

access_token = generateAccessToken()

text = File.read('create_case.json')
obj = JSON.parse(text);
request = JSON.generate(obj)
createCase(access_token, request)







