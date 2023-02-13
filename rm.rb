#!/usr/bin/env ruby

require_relative './lib/commander.rb'

Commander.call
# Если программа без флагов, то она просто удаляет файлы (автоматически вызывает file to bin)
