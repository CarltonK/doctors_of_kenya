class SocialMediaModel {
  String twitterHandle;
  String facebookHandle;
  String youtubeHandle;

  SocialMediaModel({
    this.twitterHandle,
    this.facebookHandle,
    this.youtubeHandle,
  });

  Map<String, dynamic> toJson() => {
        'twitterHandle': twitterHandle,
        'facebookHandle': facebookHandle,
        'youtubeHandle': youtubeHandle,
      };
}
