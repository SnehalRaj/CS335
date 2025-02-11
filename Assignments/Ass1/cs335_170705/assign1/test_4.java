/**
 * Run test with ---patch-module and exploded patches
 */
public void testWithExplodedPatches() throws Exception {

    // patches1/java.base:patches2/java.base
    String basePatches = PATCHES1_DIR.resolve("java.base")
            + File.pathSeparator + PATCHES2_DIR.resolve("java.base");

    String dnsPatches = PATCHES1_DIR.resolve("jdk.naming.dns")
            + File.pathSeparator + PATCHES2_DIR.resolve("jdk.naming.dns");

    String compilerPatches = PATCHES1_DIR.resolve("jdk.compiler")
            + File.pathSeparator + PATCHES2_DIR.resolve("jdk.compiler");

    runTest(basePatches, dnsPatches, compilerPatches);
}
/**
 * Accepts exact path to a given command. A command may be in
 * uneven quotes (both single and double).
 */
public static boolean commandIsAvailable(final String command) {
  try {
    final String quotedCommand = StringUtils.putIntoDoubleQuotes(command);
    final String[] parsed = new CommandLineParser().parse(quotedCommand);
    if (parsed.length != 1) return false; // not a single command
    final File commmandFile = new File(parsed[0]);
    // first try to find given executable file in path if command is not in path
    if (!commmandFile.isAbsolute()) {
      final String pathVariable = getEnvVariable(isWindows() ? "Path" : "PATH");
      final StringTokenizer stPath = new StringTokenizer(pathVariable, File.pathSeparator, false);
      while (stPath.hasMoreTokens()) {
        String commandToCheck = null;
        if (isWindows() && !command.endsWith(EXE_SUFFIX)) {
          commandToCheck = command + EXE_SUFFIX;
        } else {
          commandToCheck = command;
        }
        final String path = stPath.nextToken();
        final File fullPath = new File(path, commandToCheck);
        if (fullPath.exists() && fullPath.isFile()) return true;
      }
    }
    if (!commmandFile.exists()) return false;
    return commmandFile.isFile();
  } catch (CommandLineParserException e) {
    return false;
  }
}