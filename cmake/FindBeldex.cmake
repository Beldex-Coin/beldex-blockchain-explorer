#------------------------------------------------------------------------------
# CMake helper for the majority of the cpp-ethereum modules.
#
# This module defines
#     BELDEX_XXX_LIBRARIES, the libraries needed to use ethereum.
#     BELDEX_FOUND, If false, do not try to use ethereum.
#
# File addetped from cpp-ethereum
#
# The documentation for cpp-ethereum is hosted at http://cpp-ethereum.org
#
# ------------------------------------------------------------------------------
# This file is part of cpp-ethereum.
#
# cpp-ethereum is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# cpp-ethereum is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with cpp-ethereum.  If not, see <http://www.gnu.org/licenses/>
#
# (c) 2014-2016 cpp-ethereum contributors.
#------------------------------------------------------------------------------

set(LIBS common;blocks;cryptonote_basic;cryptonote_core;multisig;
		cryptonote_protocol;daemonizer;mnemonics;epee;lmdb;device;
		blockchain_db;ringct;wallet;cncrypto;easylogging;version;checkpoints)

    set(LOK_INCLUDE_DIRS "${CPP_BELDEX_DIR}")

# if the project is a subset of main cpp-ethereum project
# use same pattern for variables as Boost uses

foreach (l ${LIBS})

	string(TOUPPER ${l} L)

	find_library(LOK_${L}_LIBRARY
		NAMES ${l}
		PATHS ${CMAKE_LIBRARY_PATH}
		PATH_SUFFIXES "/src/${l}" "/src/" "/external/db_drivers/lib${l}" "/lib" "/src/crypto" "/contrib/epee/src" "/external/easylogging++/"
		NO_DEFAULT_PATH
	)

	set(LOK_${L}_LIBRARIES ${LOK_${L}_LIBRARY})

    message(STATUS FindBeldex " LOK_${L}_LIBRARIES ${LOK_${L}_LIBRARY}")

	add_library(${l} STATIC IMPORTED)
	set_property(TARGET ${l} PROPERTY IMPORTED_LOCATION ${LOK_${L}_LIBRARIES})

endforeach()

if (EXISTS ${BELDEX_BUILD_DIR}/src/ringct/libringct_basic.a)
	message(STATUS FindBeldex " found libringct_basic.a")
	add_library(ringct_basic STATIC IMPORTED)
	set_property(TARGET ringct_basic
		PROPERTY IMPORTED_LOCATION ${BELDEX_BUILD_DIR}/src/ringct/libringct_basic.a)
endif()


message(STATUS ${BELDEX_SOURCE_DIR}/build)

# include beldex headers
include_directories(
    ${BELDEX_SOURCE_DIR}/src
    ${BELDEX_SOURCE_DIR}/external
    ${BELDEX_SOURCE_DIR}/build
    ${BELDEX_SOURCE_DIR}/external/easylogging++
    ${BELDEX_SOURCE_DIR}/contrib/epee/include
    ${BELDEX_SOURCE_DIR}/external/db_drivers/liblmdb)
