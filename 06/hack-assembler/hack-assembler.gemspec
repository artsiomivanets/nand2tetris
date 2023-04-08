require_relative 'lib/hack/assembler/version'

Gem::Specification.new do |spec|
  spec.name          = 'hack-assembler'
  spec.version       = Hack::Assembler::VERSION
  spec.authors       = ['artsiomivanets']
  spec.email         = ['artem.ivanec96@gmail.com']

  spec.summary       = 'Write a short summary, because RubyGems requires one.'
  spec.description   = 'Write a longer description or delete this line.'
  spec.homepage      = 'https://google.com'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = 'https://google.com'
  spec.metadata['source_code_uri'] = 'https://google.com'
  spec.metadata['changelog_uri'] = 'https://google.com'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end