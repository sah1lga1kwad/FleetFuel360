allprojects {
    repositories {
        google()
        mavenCentral()
        // Required for flutter_background_geolocation bundled AARs (tslocationmanager 3.x).
        maven(url = uri("${project(":flutter_background_geolocation").projectDir}/libs"))
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// Workaround for older plugins (e.g. isar_flutter_libs) missing AGP 8 namespace.
subprojects {
    if (name == "isar_flutter_libs") {
        pluginManager.withPlugin("com.android.library") {
            val androidExt = extensions.findByName("android") ?: return@withPlugin
            val getNamespace = androidExt.javaClass.methods
                .firstOrNull { it.name == "getNamespace" && it.parameterCount == 0 }
            val setNamespace = androidExt.javaClass.methods
                .firstOrNull { it.name == "setNamespace" && it.parameterCount == 1 }
            val namespace = getNamespace?.invoke(androidExt) as? String
            if (namespace.isNullOrBlank()) {
                setNamespace?.invoke(androidExt, "dev.isar.isar_flutter_libs")
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
