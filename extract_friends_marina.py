import tweepy
import pandas as pd

d = {'MarinaSilva_following': ['dummy'], 'followers': '0'}
df = pd.DataFrame(d, columns=['twitter_user', 'followers'], index=[0])

access_token = "1086313099144122368-Jn7mtPdjLqGuWLUdEo9Sv8EzrGYSQr"
access_token_secret = "uZ2Cw4ZmTipBDCdbNcPaNpsgmRPyAXjIKqc5u4d7hAlQg"
consumer_key = "qfGNpjydBt0adVJggVlvyXAHj"
consumer_secret = "S7NF7LIG3wo8526r9axW6viL204xHgGe9zOTrwhrztFIzoZcrj"

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth, wait_on_rate_limit=True)

for user in tweepy.Cursor(api.friends, screen_name="MarinaSilva").items():
    print('friend: ' + user.screen_name)
    df = df.append({'twitter_user': f"{user.screen_name}", 'followers': f"{user.followers_count}"}, ignore_index=True)

df.to_csv('MarinaSilva_following.csv', index=False)
df.to_excel('MarinaSilva_following.xlsx', index=False)
