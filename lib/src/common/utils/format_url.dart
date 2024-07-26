String formatUrl(String template, List<String> args) {
  return args.fold(template, (prev, arg) => prev.replaceFirst('%s', arg));
}
