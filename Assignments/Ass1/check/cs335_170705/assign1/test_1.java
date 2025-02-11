Map<String, String> buildEnvironment(Map<String, String> original) {
    Map<String, String> ret = new HashMap<String, String>(original);
    ret.putAll(envVariables);

    // Find PATH environment variable - on Windows it can be some other
    // case and we should use whatever it has.
    String pathName = getPathName(original);

    // TODO use StringBuilder
    String currentPath = ret.get(pathName);

    if (currentPath == null) {
        currentPath = "";
    }

    for (File path : paths) {
        currentPath = path.getAbsolutePath().replace(" ", "\\ ") //NOI18N
                + File.pathSeparator + currentPath;
    }

    if (!"".equals(currentPath.trim())) {
        ret.put(pathName, currentPath);
    }
    String currentPath = current.get(pathName);

    if (currentPath == null) {
        currentPath = "";
    }

    if (prepend) {
        currentPath = path.getAbsolutePath().replace(" ", "\\ ") //NOI18N
                + File.pathSeparator + currentPath;
    } else {
        currentPath = currentPath + File.pathSeparator
                + path.getAbsolutePath().replace(" ", "\\ "); //NOI18N
    }

    if (!"".equals(currentPath.trim())) {
        current.put(pathName, currentPath);
    }
    return ret;
}
 