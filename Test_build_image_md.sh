#!/usr/bin/env bash
git checkout -b sonic_latest_images_links
git config --global user.email "kannan_kvs@dell.com"
git config --global user.name "kannankvs"
git reset --hard
git pull origin sonic_latest_images_links

#set -euo pipefail

DEFID_BRCM="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/definitions?name=Azure.sonic-buildimage.official.broadcom' | jq -r '.value[0].id')"
DEFID_MLNX="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/definitions?name=Azure.sonic-buildimage.official.mellanox' | jq -r '.value[0].id')"
DEFID_VS="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/definitions?name=Azure.sonic-buildimage.official.vs' | jq -r '.value[0].id')"
DEFID_INNO="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/definitions?name=Azure.sonic-buildimage.official.innovium' | jq -r '.value[0].id')"
DEFID_BFT="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/definitions?name=Azure.sonic-buildimage.official.barefoot' | jq -r '.value[0].id')"
DEFID_CHE="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/definitions?name=Azure.sonic-buildimage.official.cache' | jq -r '.value[0].id')"
DEFID_CTC="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/definitions?name=Azure.sonic-buildimage.official.centec' | jq -r '.value[0].id')"
DEFID_CTC64="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/definitions?name=Azure.sonic-buildimage.official.centec-arm64' | jq -r '.value[0].id')"
DEFID_GRC="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/definitions?name=Azure.sonic-buildimage.official.generic' | jq -r '.value[0].id')"
DEFID_MRV="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/definitions?name=Azure.sonic-buildimage.official.marvell-armhf' | jq -r '.value[0].id')"
DEFID_NPH="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/definitions?name=Azure.sonic-buildimage.official.nephos' | jq -r '.value[0].id')"

echo '{' > Test1.md2
first=1
for BRANCH in  master   
do
	if [ -z "${first}" ]; then
		echo ',' >> Test1.md2
	fi
	first=''
	BUILD_BRCM="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds?definitions='"${DEFID_BRCM}"'&branchName=refs/heads/'"${BRANCH}"'&$top=1&resultFilter=succeeded&api-version=6.0' | jq -r '.value[0].id')"
	BUILD_BRCM_TS="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_BRCM}"'?api-version=6.0' | jq -r '.queueTime')"
	BUILD_MLNX="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds?definitions='"${DEFID_MLNX}"'&branchName=refs/heads/'"${BRANCH}"'&$top=1&resultFilter=succeeded&api-version=6.0' | jq -r '.value[0].id')"
	BUILD_MLNX_TS="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_MLNX}"'?api-version=6.0' | jq -r '.queueTime')"
	BUILD_VS="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds?definitions='"${DEFID_VS}"'&branchName=refs/heads/'"${BRANCH}"'&$top=1&resultFilter=succeeded&api-version=6.0' | jq -r '.value[0].id')"
	BUILD_VS_TS="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_VS}"'?api-version=6.0' | jq -r '.queueTime')"
	BUILD_INNO="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds?definitions='"${DEFID_INNO}"'&branchName=refs/heads/'"${BRANCH}"'&$top=1&resultFilter=succeeded&api-version=6.0' | jq -r '.value[0].id')"
	BUILD_INNO_TS="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_INNO}"'?api-version=6.0' | jq -r '.queueTime')"
	BUILD_BFT="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds?definitions='"${DEFID_BFT}"'&branchName=refs/heads/'"${BRANCH}"'&$top=1&resultFilter=succeeded&api-version=6.0' | jq -r '.value[0].id')"
	BUILD_BFT_TS="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_BFT}"'?api-version=6.0' | jq -r '.queueTime')"
	BUILD_CHE="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds?definitions='"${DEFID_CHE}"'&branchName=refs/heads/'"${BRANCH}"'&$top=1&resultFilter=succeeded&api-version=6.0' | jq -r '.value[0].id')"
	BUILD_CHE_TS="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_CHE}"'?api-version=6.0' | jq -r '.queueTime')"
	BUILD_CTC="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds?definitions='"${DEFID_CTC}"'&branchName=refs/heads/'"${BRANCH}"'&$top=1&resultFilter=succeeded&api-version=6.0' | jq -r '.value[0].id')"
	BUILD_CTC_TS="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_CTC}"'?api-version=6.0' | jq -r '.queueTime')"
	BUILD_CTC64="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds?definitions='"${DEFID_CTC64}"'&branchName=refs/heads/'"${BRANCH}"'&$top=1&resultFilter=succeeded&api-version=6.0' | jq -r '.value[0].id')"
	BUILD_CTC64_TS="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_CTC64}"'?api-version=6.0' | jq -r '.queueTime')"
	BUILD_GRC="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds?definitions='"${DEFID_GRC}"'&branchName=refs/heads/'"${BRANCH}"'&$top=1&resultFilter=succeeded&api-version=6.0' | jq -r '.value[0].id')"
	BUILD_GRC_TS="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_GRC}"'?api-version=6.0' | jq -r '.queueTime')"
	BUILD_MRV="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds?definitions='"${DEFID_MRV}"'&branchName=refs/heads/'"${BRANCH}"'&$top=1&resultFilter=succeeded&api-version=6.0' | jq -r '.value[0].id')"
	BUILD_MRV_TS="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_MRV}"'?api-version=6.0' | jq -r '.queueTime')"
	BUILD_NPH="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds?definitions='"${DEFID_NPH}"'&branchName=refs/heads/'"${BRANCH}"'&$top=1&resultFilter=succeeded&api-version=6.0' | jq -r '.value[0].id')"
	BUILD_NPH_TS="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_NPH}"'?api-version=6.0' | jq -r '.queueTime')"

	#echo " [*] Last successful builds for \"${BRANCH}\":"
	#echo "     Broadcom: ${BUILD_BRCM}"
	#echo "     Mellanox: ${BUILD_MLNX}"
	#echo "     Virtual Switch: ${BUILD_VS}"

	ARTF_BRCM="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_BRCM}"'/artifacts?artifactName=sonic-buildimage.broadcom&api-version=5.1' | jq -r '.resource.downloadUrl')"
	ARTF_MLNX="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_MLNX}"'/artifacts?artifactName=sonic-buildimage.mellanox&api-version=5.1' | jq -r '.resource.downloadUrl')"
	ARTF_VS="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_VS}"'/artifacts?artifactName=sonic-buildimage.vs&api-version=5.1' | jq -r '.resource.downloadUrl')"
	ARTF_INNO="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_INNO}"'/artifacts?artifactName=sonic-buildimage.innovium&api-version=5.1' | jq -r '.resource.downloadUrl')"
	ARTF_BFT="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_BFT}"'/artifacts?artifactName=sonic-buildimage.barefoot&api-version=5.1' | jq -r '.resource.downloadUrl')"
	ARTF_CHE="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_CHE}"'/artifacts?artifactName=sonic-buildimage.cache&api-version=5.1' | jq -r '.resource.downloadUrl')"
	ARTF_CTC="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_CTC}"'/artifacts?artifactName=sonic-buildimage.centec&api-version=5.1' | jq -r '.resource.downloadUrl')"
	ARTF_CTC64="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_CTC64}"'/artifacts?artifactName=sonic-buildimage.centec-arm64&api-version=5.1' | jq -r '.resource.downloadUrl')"
	ARTF_GRC="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_GRC}"'/artifacts?artifactName=sonic-buildimage.generic&api-version=5.1' | jq -r '.resource.downloadUrl')"
	ARTF_MRV="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_MRV}"'/artifacts?artifactName=sonic-buildimage.marvell-armhf&api-version=5.1' | jq -r '.resource.downloadUrl')"
	ARTF_NPH="$(curl -s 'https://dev.azure.com/mssonic/build/_apis/build/builds/'"${BUILD_NPH}"'/artifacts?artifactName=sonic-buildimage.nephos&api-version=5.1' | jq -r '.resource.downloadUrl')"

echo "# Supported \"abcd\" Platforms" >> Test1.md2

echo "#### Following is the list of platforms that supports SONiC." >> T1.md2
echo "| S.No | Vendor         | Platform       		| ASIC Vendor | Switch ASIC       | Port Configuration  	| Image                                                        |" >> Test1.md2
echo "| ---- | -------------- | ----------- | ----------------- | ----------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |" >> Test1.md2
echo "| 1    | Accton    	| AS4630-54PE    		| Broadcom    | Helix 5           | 48x1G + 4x25G + 2x100G  | [SONiC-ONIE-Broadcom]($(echo "${ARTF_BRCM}" | sed 's/format=zip/format=file\&subpath=\/target\/sonic-broadcom.bin/')) |" >> Test1.md2
echo "| 2    | Accton    	| AS5712-54X     		| Broadcom    | Trident 2         | 72x10G                  | [SONiC-ONIE-Broadcom](sonic_broadcom_bin) |" >> Test1.md2
echo "| 3    | Accton    	| AS5812-54X     		| Broadcom    | Trident 2         | 72x10G                  | [SONiC-ONIE-Broadcom](sonic_broadcom_bin) |" >> Test1.md2

	echo "\"${BRANCH}\": {" >> Test1.md2
	echo "\"sonic-broadcom.bin\": {" >> Test1.md2
	echo "  \"url\": \"$(echo "${ARTF_BRCM}" | sed 's/format=zip/format=file\&subpath=\/target\/sonic-broadcom.bin/')\","  >> Test1.md2
	echo "  \"build-url\": \"https://dev.azure.com/mssonic/build/_build/results?buildId=${BUILD_BRCM}&view=results\"," >> Test1.md2
	echo "  \"build\": \"${BUILD_BRCM}\"," >> Test1.md2
	echo "  \"date\": \"${BUILD_BRCM_TS}\"" >> Test1.md2
	echo " }," >> Test1.md2
	echo "\"sonic-aboot-broadcom.swi\": {" >> Test1.md2
	echo "  \"url\": \"$(echo "${ARTF_BRCM}" | sed 's/format=zip/format=file\&subpath=\/target\/sonic-aboot-broadcom.swi/')\"," >> Test1.md2
	echo "  \"build-url\": \"https://dev.azure.com/mssonic/build/_build/results?buildId=${BUILD_BRCM}&view=results\"," >> Test1.md2
	echo "  \"build\": \"${BUILD_BRCM}\"," >> Test1.md2
	echo "  \"date\": \"${BUILD_BRCM_TS}\"" >> Test1.md2
	echo " }," >> Test1.md2
	echo "\"sonic-mellanox.bin\": {" >> Test1.md2
	echo "  \"url\": \"$(echo "${ARTF_MLNX}" | sed 's/format=zip/format=file\&subpath=\/target\/sonic-mellanox.bin/')\"," >> Test1.md2
	echo "  \"build-url\": \"https://dev.azure.com/mssonic/build/_build/results?buildId=${BUILD_MLNX}&view=results\"," >> Test1.md2
	echo "  \"build\": \"${BUILD_MLNX}\"," >> Test1.md2
	echo "  \"date\": \"${BUILD_MLNX_TS}\"" >> Test1.md2
	echo " }," >> Test1.md2
	echo "\"sonic-vs.img.gz\": {" >> Test1.md2
	echo "  \"url\": \"$(echo "${ARTF_VS}" | sed 's/format=zip/format=file\&subpath=\/target\/sonic-vs.img.gz/')\"," >> Test1.md2
	echo "  \"build-url\": \"https://dev.azure.com/mssonic/build/_build/results?buildId=${BUILD_VS}&view=results\"," >> Test1.md2
	echo "  \"build\": \"${BUILD_VS}\"," >> Test1.md2
	echo "  \"date\": \"${BUILD_VS_TS}\"" >> Test1.md2
	echo " }," >> Test1.md2
	echo "\"sonic-innovium.bin\": {" >> Test1.md2
	echo "  \"url\": \"$(echo "${ARTF_INNO}" | sed 's/format=zip/format=file\&subpath=\/target\/sonic-innovium.bin/')\"," >> Test1.md2
	echo "  \"build-url\": \"https://dev.azure.com/mssonic/build/_build/results?buildId=${BUILD_INNO}&view=results\"," >> Test1.md2
	echo "  \"build\": \"${BUILD_INNO}\"," >> Test1.md2
	echo "  \"date\": \"${BUILD_INNO_TS}\"" >> Test1.md2
	echo " }," >> Test1.md2
	echo "\"sonic-innovium-dbg.bin\": {" >> Test1.md2
	echo "  \"url\": \"$(echo "${ARTF_INNO}" | sed 's/format=zip/format=file\&subpath=\/target\/sonic-innovium-dbg.bin/')\"," >> Test1.md2
	echo "  \"build-url\": \"https://dev.azure.com/mssonic/build/_build/results?buildId=${BUILD_INNO}&view=results\"," >> Test1.md2
	echo "  \"build\": \"${BUILD_INNO}\"," >> Test1.md2
	echo "  \"date\": \"${BUILD_INNO_TS}\"" >> Test1.md2	
	echo " }," >> Test1.md2
	echo "\"sonic-barefoot.bin\": {" >> Test1.md2
	echo "  \"url\": \"$(echo "${ARTF_BFT}" | sed 's/format=zip/format=file\&subpath=\/target\/sonic-barefoot.bin/')\"," >> Test1.md2
	echo "  \"build-url\": \"https://dev.azure.com/mssonic/build/_build/results?buildId=${BUILD_BFT}&view=results\"," >> Test1.md2
	echo "  \"build\": \"${BUILD_BFT}\"," >> Test1.md2
	echo "  \"date\": \"${BUILD_BFT_TS}\"" >> Test1.md2
	echo " }," >> Test1.md2
	echo "\"sonic-centec.bin\": {" >> Test1.md2
	echo "  \"url\": \"$(echo "${ARTF_CTC}" | sed 's/format=zip/format=file\&subpath=\/target\/sonic-centec.bin/')\"," >> Test1.md2
	echo "  \"build-url\": \"https://dev.azure.com/mssonic/build/_build/results?buildId=${BUILD_CTC}&view=results\"," >> Test1.md2
	echo "  \"build\": \"${BUILD_CTC}\"," >> Test1.md2
	echo "  \"date\": \"${BUILD_CTC_TS}\"" >> Test1.md2
	echo " }," >> Test1.md2
	echo "\"sonic-centec-arm64.bin\": {" >> Test1.md2
	echo "  \"url\": \"$(echo "${ARTF_CTC64}" | sed 's/format=zip/format=file\&subpath=\/target\/sonic-centec-arm64.bin/')\"," >> Test1.md2
	echo "  \"build-url\": \"https://dev.azure.com/mssonic/build/_build/results?buildId=${BUILD_CTC64}&view=results\"," >> Test1.md2
	echo "  \"build\": \"${BUILD_CTC64}\"," >> Test1.md2
	echo "  \"date\": \"${BUILD_CTC64_TS}\"" >> Test1.md2
	echo " }," >> Test1.md2
	echo "\"sonic-generic.bin\": {" >> Test1.md2
	echo "  \"url\": \"$(echo "${ARTF_GRC}" | sed 's/format=zip/format=file\&subpath=\/target\/sonic-generic.bin/')\"," >> Test1.md2
	echo "  \"build-url\": \"https://dev.azure.com/mssonic/build/_build/results?buildId=${BUILD_GRC}&view=results\"," >> Test1.md2
	echo "  \"build\": \"${BUILD_GRC}\"," >> Test1.md2
	echo "  \"date\": \"${BUILD_GRC_TS}\"" >> Test1.md2
	echo " }," >> Test1.md2
	echo "\"sonic-generic-dbg.bin\": {" >> Test1.md2
	echo "  \"url\": \"$(echo "${ARTF_GRC}" | sed 's/format=zip/format=file\&subpath=\/target\/sonic-generic-dbg.bin/')\"," >> Test1.md2
	echo "  \"build-url\": \"https://dev.azure.com/mssonic/build/_build/results?buildId=${BUILD_GRC}&view=results\"," >> Test1.md2
	echo "  \"build\": \"${BUILD_GRC}\"," >> Test1.md2
	echo "  \"date\": \"${BUILD_GRC_TS}\"" >> Test1.md2	
	echo " }," >> Test1.md2
	echo "\"sonic-marvell-armhf.bin\": {" >> Test1.md2
	echo "  \"url\": \"$(echo "${ARTF_MRV}" | sed 's/format=zip/format=file\&subpath=\/target\/sonic-marvell-armhf.bin/')\"," >> Test1.md2
	echo "  \"build-url\": \"https://dev.azure.com/mssonic/build/_build/results?buildId=${BUILD_MRV}&view=results\"," >> Test1.md2
	echo "  \"build\": \"${BUILD_MRV}\"," >> Test1.md2
	echo "  \"date\": \"${BUILD_MRV_TS}\"" >> Test1.md2
	echo " }," >> Test1.md2
	echo "\"sonic-nephos.bin\": {" >> Test1.md2
	echo "  \"url\": \"$(echo "${ARTF_NPH}" | sed 's/format=zip/format=file\&subpath=\/target\/sonic-nephos.bin/')\"," >> Test1.md2
	echo "  \"build-url\": \"https://dev.azure.com/mssonic/build/_build/results?buildId=${BUILD_NPH}&view=results\"," >> Test1.md2
	echo "  \"build\": \"${BUILD_NPH}\"," >> Test1.md2
	echo "  \"date\": \"${BUILD_NPH_TS}\"" >> Test1.md2
	echo " }" >> Test1.md2
	echo -n "}" >> Test1.md2
done
echo "\n}" >> Test1.md2

git add Test1.md2
git commit -m "latest links for sonic images in dedicated branch sonic_latest_images_links"
git push -f --set-upstream origin sonic_latest_images_links
