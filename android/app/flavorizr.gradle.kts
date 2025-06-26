import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("app")

    productFlavors {
        create("dev") {
            dimension = "app"
            applicationId = "com.example.palmbookapp.dev"
            resValue(type = "string", name = "app_name", value = "Palm Book App Dev")
        }
        create("staging") {
            dimension = "app"
            applicationId = "com.example.palmbookapp.staging"
            resValue(type = "string", name = "app_name", value = "Palm Book App Staging")
        }
        create("production") {
            dimension = "app"
            applicationId = "com.example.palmbookapp"
            resValue(type = "string", name = "app_name", value = "Palm Book App")
        }
    }
}