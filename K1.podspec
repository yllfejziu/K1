Pod::Spec.new do |spec|
  spec.name         = "K1"
  spec.version      = "0.4.0"
  spec.summary      = "K1 is Swift wrapper around libsecp256k1 (bitcoin-core/secp256k1), offering ECDSA, Schnorr (BIP340) and ECDH features."
  spec.description  = <<-DESC
                       K1 is a Swift package that wraps the libsecp256k1 library, offering a Swift-friendly API for ECDSA, Schnorr (BIP340), and ECDH features, with performance and security as primary goals.
                       DESC
  spec.homepage     = "https://github.com/yllfejziu/K1"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Yll Fejziu" => "yllfejziu@gmail.com" }
  spec.source       = { :git => "https://github.com/yllfejziu/K1.git", :tag => "#{spec.version}", :submodules => true }

  spec.ios.deployment_target = '13.0'
  spec.swift_versions = '5.0'

  spec.preserve_path = 'Sources/**/*'

  spec.pod_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => '"${PODS_TARGET_SRCROOT}/Sources/"',
    'GCC_PREPROCESSOR_DEFINITIONS' => 'ECMULT_WINDOW_SIZE=15 ECMULT_GEN_PREC_BITS=4 ENABLE_MODULE_ECDH=1 ENABLE_MODULE_RECOVERY=1 ENABLE_MODULE_SCHNORRSIG=1 ENABLE_MODULE_EXTRAKEYS=1',
    'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => 'CRYPTO_IN_SWIFTPM_FORCE_BUILD_API',
    'GENERATE_INFOPLIST_FILE' => 'YES'
  }

  spec.source_files = 'Sources/secp256k1/libsecp256k1/{src,include,contrib}/*.{h,c}', 'Sources/secp256k1/libsecp256k1/src/modules/{ecdh}/*.{h,c}', 'Sources/K1/**/*.swift','Sources/secp256k1/{src,include}/*.{h,c}',
  spec.public_header_files = 'Sources/secp256k1/libsecp256k1/include/*.h'
  spec.private_header_files = 'Sources/secp256k1/libsecp256k1/*.h', 'Sources/secp256k1/libsecp256k1/{contrib,src}/*.h', 'Sources/secp256k1/libsecp256k1/src/modules/{ecdh}/*.h'
  spec.exclude_files = ['Sources/secp256k1/libsecp256k1/src/*test*.{c,h}', 
  	'Sources/secp256k1/libsecp256k1/src/gen_context.c', 
  	'Sources/secp256k1/libsecp256k1/src/*bench*.{c,h}', 
  	'Sources/secp256k1/libsecp256k1/src/modules/**/*test*.{c,h}',
  	'Sources/secp256k1/libsecp256k1/src/*precompute_ecmult*',
  ]
end