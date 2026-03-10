/// Build full image URLs from relative paths or IDs.
abstract class ImageUrlBuilder {
  ImageUrlBuilder._();

  // TODO: Combine base URL with path/placeholder
  static String build(String path) => path;
}
