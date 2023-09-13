#!/bin/bash

# Get the module name from the user
read -p "Enter the name of the new module (e.g., user_profile): " module_name

# Convert module name to CamelCase for class naming
module_class_name="$(echo $module_name | sed -r 's/(^|-)([a-z])/\U\2/g')"

# Create the module directory structure
mkdir -p lib/app/$module_name/datasource/data
mkdir -p lib/app/$module_name/datasource/repository
mkdir -p lib/app/$module_name/domain/usecase
mkdir -p lib/app/$module_name/ui/controller
mkdir -p lib/app/$module_name/ui/page

# Create the main module.dart file with the initial structure
cat > lib/app/$module_name/${module_name}_module.dart <<EOL
import 'package:flutter_modular/flutter_modular.dart';

class ${module_class_name}Module extends Module {
  @override
  void binds(i) {
    // Add your dependencies here
  }

  @override
  void routes(r) {
    // Define your routes here
  }
}
EOL

# Add the module import to the main.dart file
sed -i "/import 'app\/addTransaction\/addTransaction_module.dart';/a import 'app\/$module_name\/${module_name}_module.dart';" lib/main.dart

# Add the new module to the AppModule class in main.dart
sed -i "/r.module('\/addTransaction', module: AddTransactionModule());/a \ \ \ \ r.module('\/$module_name', module: ${module_class_name}Module());" lib/main.dart

echo "Module $module_name added successfully!"
