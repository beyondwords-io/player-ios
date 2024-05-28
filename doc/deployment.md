## Deployment

The deployment process is automated by the [release](../.github/workflows/release.yml) workflow, running on GitHub Actions, triggered on each GitHub release. It uploads a `.framework` artifact in the release assets and publishes a new version to [CocoaPods](https://cocoapods.org/).

To publish the cocoapod package you must set a `COCOAPODS_TRUNK_TOKEN` GitHub secret.

To obtain that token you must login in the cocoapods CLI

```bash
pod trunk register tech@beyondwords.io 'Your Name' --description='macbook pro'
```

Copy the value of the Authorization header

```bash
pod trunk me --verbose

opening connection to trunk.cocoapods.org:443...
opened
starting SSL for trunk.cocoapods.org:443...
SSL established, protocol: TLSv1.3, cipher: XXXXXX
<- "GET /api/v1/sessions HTTP/1.1\r\nContent-Type: application/json; charset=utf-8\r\nAccept: application/json; charset=utf-8\r\nUser-Agent: CocoaPods/1.12.1\r\nAuthorization: Token XXXXXX\r\nAccept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3\r\nHost: trunk.cocoapods.org\r\n\r\n"
-> "HTTP/1.1 200 OK\r\n"
```
