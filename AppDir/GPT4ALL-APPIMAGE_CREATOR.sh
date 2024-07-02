#!/bin/bash

# rizitis 2024 GR
# create an AppImage for GPT4All 

#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# NOTE: You should NOT run AppImage from everyone (like me), 
# you should only from official creators.
# This script will download and create an AppImage in a Slackware64-current system
# Some small edits can make it work for your linux system also if not as is.. 
# The reason for this AppImage is only one. Because its dont provide AppImages officially...so far.
# Althought you dont need it because GPT4All packages are fine as is for installation but just in case...
# GPT4All has nothing to do with this AppImage. YOU USE IT AT YOUR OWN RISK ELSE DONT USE IT...

cd "$(dirname "$0")" || exit
CWD=$(pwd)
WORKSPACE_DIR="$CWD/work-space"
LOG_FILE="$WORKSPACE_DIR/installation.log"

PRGNAM="gpt4all"
GPT4ALL_VERSION="3.0.0"
BTYPE="x86_64-1_rtz.txz"

GPT4ALL_BINARY_URL=https://github.com/rizitis/GPT4All.SlackBuild/releases/download/"$GPT4ALL_VERSION"/"$PRGNAM"-"$GPT4ALL_VERSION"-"$BTYPE"
#                  https://github.com/rizitis/GPT4All.SlackBuild/releases/download/3.0.0/gpt4all-3.0.0-x86_64-1_rtz.txz

GPT4ALL_BINARY_FILE="$PRGNAM"-""$GPT4ALL_VERSION-"$BTYPE"

PKG="AppDir"
CWD2="work-space"


rm -r "$CWD2"
echo "Creating $CWD2"
sleep 1
mkdir -p "$CWD2"

log() {
    echo "$(date): $1" >> "$LOG_FILE"
}

# Error handling
handle_error() {
    log "Error: $1"
    echo "Error: $1"
    exit 1
}

# Create log file
echo "" > "$LOG_FILE"
log "Change to workspace."
cd "$CWD2" || exit 1

echo "Downloading GPT4ALL binary"
sleep 1
log "Downloading GPT4ALL binary."
wget "$GPT4ALL_BINARY_URL" -O "$GPT4ALL_BINARY_FILE" || handle_error "Failed to download GPT4ALL binary."
echo "Extracting GPT4ALL binary and removing archive"
sleep 1
log "Extracting GPT4ALL binary."
tar -xf "$GPT4ALL_BINARY_FILE" || handle_error "Failed to extract GPT4ALL binary."
rm "$GPT4ALL_BINARY_FILE" || handle_error "Failed to remove GPT4ALL binary archive."
log "Creating AppDir."
echo "Creating $PKG"
sleep 1
mkdir -p "$PKG" || handle_error "Failed to create AppDir."
cd "$PKG" || exit 1
echo "Moving the extracted binary to $PKG"
log "Copying files from GPT4ALL binary."
cp "$CWD"/*.desktop . || exit
mv  ../usr/share/GPT4All/icons/48x48/logo-48.png .
mkdir -p usr/
cp -r ../usr/local/bin/GPT4All/*  usr/ || exit 90
cp /usr/bin/fcitx5-qt6-immodule-probing usr/bin/
mkdir -p usr/include/poppler/qt6
mkdir -p usr/include/qt6
cp -r /usr/include/qt6/* usr/include/qt6/
cp -r /usr/include/Fcitx5Qt6* usr/include/
cp -r /usr/include/phonon4qt6 usr/include/ #maybe needed...idk
cp -r /usr/include/poppler/qt6/poppler* usr/include/poppler/qt6/ #maybe needed for read pdf`s in localdocs
mkdir -p usr/lib{64} || exit 12
cp -r /usr/lib/qt6* usr/lib
cp -r /usr/lib64/*qt6* usr/lib64/
cp -r /usr/lib64/fcitx5* usr/lib64/
cp -r /usr/lib64/libstdc++.so.* usr/lib64/ || handle_error "Failed to copy libstdc++."
cp -r /usr/lib64/libQt6* usr/lib64/ || handle_error "Failed to copy Qt libraries."
cp -r /usr/lib64/qt6* usr/lib64/ || handle_error "Failed to copy qt plugins."
cp /usr/lib64/libmd4c* usr/lib64/ || handle_error "Failed to copy libmd4c libraries."
cp "$CWD"/AppRun . || exit
chmod +x AppRun
cd ..
echo "Downloading AppImageKit"
sleep 1
log "Downloading AppImageKit."
wget "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage" || handle_error "Failed to download AppImageKit."
chmod +x appimagetool-x86_64.AppImage || handle_error "Failed to make AppImageKit executable."

echo "Running AppImageKit to create AppImage"
sleep 1
log "Running AppImageKit to create AppImage."
ARCH=x86_64 ./appimagetool-x86_64.AppImage "$PKG" || handle_error "Failed to run AppImageTool."


