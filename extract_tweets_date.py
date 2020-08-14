import tweepy
from pandas import DataFrame



access_token = "1086313099144122368-Jn7mtPdjLqGuWLUdEo9Sv8EzrGYSQr"
access_token_secret = "uZ2Cw4ZmTipBDCdbNcPaNpsgmRPyAXjIKqc5u4d7hAlQg"
consumer_key = "qfGNpjydBt0adVJggVlvyXAHj"
consumer_secret = "S7NF7LIG3wo8526r9axW6viL204xHgGe9zOTrwhrztFIzoZcrj"

userID = "CarlosBolsonaro"

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth)

tweets = api.user_timeline(screen_name=userID,
                           # 200 is the maximum allowed count
                           count=200,
                           include_rts = False,
                           # Necessary to keep full_text
                           # otherwise only the first 140 words are extracted
                           until= "2019-08-27",
                           tweet_mode = 'extended'
                           )

for info in tweets[:3]:
     print("ID: {}".format(info.id))
     print(info.created_at)
     print(info.full_text)
     print("\n")

all_tweets = []
all_tweets.extend(tweets)
oldest_id = tweets[-1].id
while True:
    tweets = api.user_timeline(screen_name=userID,
                           # 200 is the maximum allowed count
                           count=200,
                           include_rts = False,
                           max_id = oldest_id - 1,
                           # Necessary to keep full_text
                           # otherwise only the first 140 words are extracted
                           tweet_mode = 'extended'
                           )
    if len(tweets) == 0:
        break
    oldest_id = tweets[-1].id
    all_tweets.extend(tweets)
    print('N of tweets downloaded till now {}'.format(len(all_tweets)))



outtweets = [[tweet.id_str,
              tweet.created_at,
              tweet.favorite_count,
              tweet.retweet_count,
              tweet.full_text.encode("utf-8").decode("utf-8")]
             for idx,tweet in enumerate(all_tweets)]

df = DataFrame(outtweets,columns=["id","created_at","favorite_count","retweet_count", "text"])
df.to_csv('%s_tweets.csv' % userID,index=False)
df.head(3)