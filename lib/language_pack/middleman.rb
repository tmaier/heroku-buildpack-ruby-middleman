require 'language_pack'
require 'language_pack/rack'

# Middleman Language Pack. http://middlemanapp.com/
class LanguagePack::Middleman < LanguagePack::Rack
  ASSETS_CACHE_LIMIT = 52428800 # bytes

  # detects if this is a Middleman app
  # @return [Boolean] true if it's a Middleman app
  def self.use?
    instrument 'middleman.use' do
      bundler.gem_version('middleman')
    end
  end

  def name
    'Middleman'
  end

  def default_build_dir
    'build'
  end
  
  def run_assets_precompile_rake_task
    instrument 'middleman.run_assets_precompile_rake_task' do

      precompile = rake.task('assets:precompile')
      return true unless precompile.is_defined?

      topic 'Building page'

      cache.load default_build_dir

      precompile.invoke(env: rake_env)
      if precompile.success?
        log 'assets_precompile', :status => 'success'        
        puts "Asset precompilation completed (#{"%.2f" % precompile.time}s)"

        cache.store default_build_dir
      else
        precompile_fail(precompile.output)
      end
    end
  end
end
