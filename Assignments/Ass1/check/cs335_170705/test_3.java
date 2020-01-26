public static void main(String[] args)
        throws Throwable {

    String baseDir = System.getProperty("user.dir") + File.separator;
    String javac = JDKToolFinder.getTestJDKTool("javac");
    String java = JDKToolFinder.getTestJDKTool("java");

    setup(baseDir);
    String srcDir = System.getProperty("test.src");
    String cp = srcDir + File.separator + "a" + File.pathSeparator
            + srcDir + File.separator + "b.jar" + File.pathSeparator
            + ".";
    List<String[]> allCMDs = List.of(
            // Compile command
            new String[]{
                    javac, "-cp", cp, "-d", ".",
                    srcDir + File.separator + TEST_NAME + ".java"
            },
            // Run test the first time
            new String[]{
                    java, "-cp", cp, TEST_NAME, "1"
            },
            // Run test the second time
            new String[]{
                    java, "-cp", cp, TEST_NAME, "2"
            }
    );

    for (String[] cmd : allCMDs) {
        ProcessTools.executeCommand(cmd)
                    .outputTo(System.out)
                    .errorTo(System.out)
                    .shouldHaveExitValue(0);
    }
}
private void startCluster(Configuration  conf) throws Exception {
  if (System.getProperty("hadoop.log.dir") == null) {
    System.setProperty("hadoop.log.dir", "target/test-dir");
  }
  conf.set("dfs.block.access.token.enable", "false");
  conf.set("dfs.permissions", "true");
  conf.set("hadoop.security.authentication", "simple");
  String cp = conf.get(YarnConfiguration.YARN_APPLICATION_CLASSPATH,
      StringUtils.join(",",
          YarnConfiguration.DEFAULT_YARN_CROSS_PLATFORM_APPLICATION_CLASSPATH))
      + File.pathSeparator + classpathDir;
  conf.set(YarnConfiguration.YARN_APPLICATION_CLASSPATH, cp);
  dfsCluster = new MiniDFSCluster.Builder(conf).build();
  FileSystem fileSystem = dfsCluster.getFileSystem();
  fileSystem.mkdirs(new Path("/tmp"));
  fileSystem.mkdirs(new Path("/user"));
  fileSystem.mkdirs(new Path("/hadoop/mapred/system"));
  fileSystem.setPermission(
    new Path("/tmp"), FsPermission.valueOf("-rwxrwxrwx"));
  fileSystem.setPermission(
    new Path("/user"), FsPermission.valueOf("-rwxrwxrwx"));
  fileSystem.setPermission(
    new Path("/hadoop/mapred/system"), FsPermission.valueOf("-rwx------"));
  FileSystem.setDefaultUri(conf, fileSystem.getUri());
  mrCluster = MiniMRClientClusterFactory.create(this.getClass(), 1, conf);

  // so the minicluster conf is avail to the containers.
  Writer writer = new FileWriter(classpathDir + "/core-site.xml");
  mrCluster.getConfig().writeXml(writer);
  writer.close();
}