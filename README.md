# Chaos Communication Congress Workshop

1. Create private and public keys

```console
openssl ecparam -name secp256k1 -genkey -noout -out did-private.pem
openssl ec -in ./did-private.pem -pubout > did.pem
```

2. Upload public key to the root of your domain

```console
scp did.pem user@hostname:~/public/
```

Now the key should be available at your-domain.com/did.pem

3. Upload social post to a public folder on your domain

```console
ssh user@hostname "mkdir -p ~/public/rsds/first-post"
scp index.html user@hostname:~/public/rsds/first-post/
```

The post now should be available at your-domain.com/rsds/first-post

4. Modify post.sh script

* Change POSTER_DOMAIN to your domain
* Change POST_DOMAIN to your domain
* Change POST_PATH to your post path
* Change BLOCK to https://instance.did-1.com/block/latest hash

5. Execute post.sh to publish your post

Now your post should be visible on [https://reader.did-1.com/posts](https://reader.did-1.com/posts)

You can also fetch posts via API for specific block like this https://instance.did-1.com/posts/blockId
