class ApiConfig {
  static const apiKey = String.fromEnvironment(
    'API_KEY', // AIzaSyDjb_oCSCgBZPMmnqfraA30Uudr2Rl7-_A
    defaultValue:
        'AIzaSyC9DFSUt3umhF79YEs1UeY4gNqXuIBVHbE', // Only used in debug builds
  );
}
