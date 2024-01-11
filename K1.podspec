Pod::Spec.new do |spec|
  spec.name         = "K1"
  spec.version      = "0.3.9"
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

  spec.preserve_path = 'Sources'
  spec.module_map = 'Sources/secp256k1/include/module.modulemap'

  spec.pod_target_xcconfig = {
    	'HEADER_SEARCH_PATHS' => '"${PODS_TARGET_SRCROOT}/Sources"',
    	'CODE_SIGNING_ALLOWED' => 'NO',
    	'GCC_PREPROCESSOR_DEFINITIONS' => 'ECMULT_WINDOW_SIZE=15 ECMULT_GEN_PREC_BITS=4 ENABLE_MODULE_ECDH=1 ENABLE_MODULE_RECOVERY=1 ENABLE_MODULE_SCHNORRSIG=1 ENABLE_MODULE_EXTRAKEYS=1',
    	'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
    	'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => 'CRYPTO_IN_SWIFTPM_FORCE_BUILD_API',
    	'CLANG_ENABLE_MODULES' => 'YES'
  	}

    spec.source_files = 'Sources/K1/**/*.{h,m,swift,c,cpp}',
                      'Sources/secp256k1/src/**/*.{h,c}',
                      'Sources/secp256k1/include/**/*'

  	spec.exclude_files = [
    	'Sources/K1/Keys/Keys.swift.gyb',
    	'Sources/K1/Signing/Signing.swift.gyb',
    	'Sources/K1/Validation/Validation.swift.gyb',
    	#'Sources/secp256k1/libsecp256k1/**/*'
  	]

  spec.subspec 'libsecp256k1' do |ss|
    ss.source_files = 'Sources/secp256k1/libsecp256k1/**/*'
    ss.exclude_files = [
    	'Sources/secp256k1/libsecp256k1/src/modules/**/*',
     	'Sources/secp256k1/libsecp256k1/cmake/**/*',
    	'Sources/secp256k1/libsecp256k1/src/asm/**/*',
    	'Sources/secp256k1/libsecp256k1/src/bench*.c',
    	'Sources/secp256k1/libsecp256k1/src/*_internal.c',
    	'Sources/secp256k1/libsecp256k1/src/precompute_ecmult*.c',
    	'Sources/secp256k1/libsecp256k1/src/tests*.c',
    	'Sources/secp256k1/libsecp256k1/src/ctime_tests.c',
    	'Sources/secp256k1/libsecp256k1/examples/**/*',
    	'Sources/secp256k1/libsecp256k1/tools/**/*',
    	'Sources/secp256k1/libsecp256k1/sage/**/*',
    	'Sources/secp256k1/libsecp256k1/contrib/**/*',
    	'Sources/secp256k1/libsecp256k1/doc/**/*',
    	'Sources/secp256k1/libsecp256k1/ci/**/*',
    	'Sources/secp256k1/libsecp256k1/build-aux/**/*',
    	'Sources/secp256k1/libsecp256k1/autogen.sh',
    	'Sources/secp256k1/libsecp256k1/CMakeLists.txt',
    	'Sources/secp256k1/libsecp256k1/configure.ac',
    	'Sources/secp256k1/libsecp256k1/COPYING',
    	'Sources/secp256k1/libsecp256k1/*.pc.in',
    	'Sources/secp256k1/libsecp256k1/Makefile.am',
    	'Sources/secp256k1/libsecp256k1/README.md',
    	'Sources/secp256k1/libsecp256k1/SECURITY.md',	
    ]
  end

  spec.subspec 'ecdh' do |ss|
  	ss.dependency 'K1/libsecp256k1'
    ss.source_files = 'Sources/secp256k1/libsecp256k1/src/modules/ecdh/**/*.h'
    ss.public_header_files = 'Sources/secp256k1/libsecp256k1/src/modules/modules/bench_impl.h',
    'Sources/secp256k1/libsecp256k1/src/modules/modules/main_impl.h'
  end

  spec.subspec 'ellswift' do |ss|
  	ss.dependency 'K1/libsecp256k1'
    ss.source_files = 'Sources/secp256k1/libsecp256k1/src/modules/ellswift/**/*.h'
    ss.public_header_files = 'Sources/secp256k1/libsecp256k1/src/modules/ellswift/bench_impl.h',
    'Sources/secp256k1/libsecp256k1/src/modules/ellswift/main_impl.h'
  end

  spec.subspec 'extrakeys' do |ss|
  	ss.dependency 'K1/libsecp256k1'
    ss.source_files = 'Sources/secp256k1/libsecp256k1/src/modules/extrakeys/**/*.h'
    ss.public_header_files = 'Sources/secp256k1/libsecp256k1/src/modules/extrakeys/main_impl.h'
  end

  spec.subspec 'recovery' do |ss|
  	ss.dependency 'K1/libsecp256k1'
    ss.source_files = 'Sources/secp256k1/libsecp256k1/src/modules/recovery/**/*.h'
    ss.public_header_files = 'Sources/secp256k1/libsecp256k1/src/modules/recovery/bench_impl.h',
    'Sources/secp256k1/libsecp256k1/src/modules/recovery/main_impl.h'
    #ss.preserve_paths = 'Sources/secp256k1/libsecp256k1/src/recovery/ecdh/Makefile.am.include'
  end

  spec.subspec 'schnorrsig' do |ss|
  	ss.dependency 'K1/libsecp256k1'
    ss.source_files = 'Sources/secp256k1/libsecp256k1/src/modules/schnorrsig/**/*.h'
    ss.public_header_files = 'Sources/secp256k1/libsecp256k1/src/modules/schnorrsig/bench_impl.h',
    'Sources/secp256k1/libsecp256k1/src/modules/schnorrsig/main_impl.h'
  end
end
