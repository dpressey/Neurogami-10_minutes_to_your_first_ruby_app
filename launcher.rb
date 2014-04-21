#! /usr/bin/env ruby

# example application to demostrate some basic Ruby features
# this code loads a given file into an associated application

class Launcher
  def initialize(app_map)
    @app_map = app_map
  end

  # execute the given file using the associate app
  def run file_name
    application = select_app file_name
    system "#{application} #{file_name}"
  end

  # given a file, look up the matching application
  def select_app file_name
    ftype = file_type file_name
    @app_map[ftype]
  end

  # return the part of the file name string after the last '.'
  def file_type file_name
    File.extname(file_name).gsub(/^\./, '').downcase
  end
end

def help
  print "
  you must pass in the path to the file to launch.

  usage: #{__FILE__} target_file
  " 
end


if ARGV.empty?
  help
  exit
else 
  app_map = {
    'html' => 'firefox',
    'rb' => 'gvim',
    'jpg' => 'gimp'
  }

  l = Launcher.new app_map
  target = ARGV.join ' '
  l.run target
end 


