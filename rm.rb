#!/usr/bin/env ruby

require_relative './lib/commander.rb'

Commander.call


# Если программа без флагов, то она просто удаляет файлы (автоматически вызывает file to bin)
# флаг --clean, очищает корзину
# флаг --silent, аутпуты исчезают
# --restore (all), восстаналивает один файл(все)
# --list - содержимое корзины
# --help

# ruby rm.rb --list
# ruby rm.rb t1 t2 t3 --silent

# --silent_mode - применяется к любой команде
# Другие команды между собой не могут)))) Флаги в скриптах/утилитах
