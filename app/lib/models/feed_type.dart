enum FeedType {
  rss,
  webPage;

  String get label => switch (this) {
        FeedType.rss => "RSS Feed",
        FeedType.webPage => "Website Page",
      };
}
