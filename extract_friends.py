import tweepy
import pandas as pd

d = {'CarlosBolsonaro_following': ['dummy'], 'followers': '0'}
df = pd.DataFrame(d, columns=['twitter_user', 'followers'], index=[0])

access_token = 
access_token_secret = 
consumer_key = 
consumer_secret = 

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth, wait_on_rate_limit=True)

for user in tweepy.Cursor(api.friends, screen_name="CarlosBolsonaro").items():
    print('friend: ' + user.screen_name)
    df = df.append({'twitter_user': f"{user.screen_name}", 'followers': f"{user.followers_count}"}, ignore_index=True)

df.to_csv('CarlosBolsonaro_following.csv', index=False)
df.to_excel('CarlosBolsonaro_following.xlsx', index=False)
