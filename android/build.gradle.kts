plugins {
    id("com.android.library")
}

group = "dev.linguaflow.flutter"
version = "0.1.0"

android {
    namespace = "dev.linguaflow.flutter"
    compileSdk = 36
    defaultConfig { minSdk = 23 }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}

dependencies {
    implementation("com.google.android.play:integrity:1.6.0")
}
