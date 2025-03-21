package kr.or.batirplan.resrce.product.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.cooperationcom.vo.CooperationcomVO;
import kr.or.batirplan.resrce.product.mapper.PrdlstMapper;
import kr.or.batirplan.resrce.product.vo.PrdlstCtgryVO;
import kr.or.batirplan.resrce.product.vo.PrdlstSearchVO;
import kr.or.batirplan.resrce.product.vo.PrdlstVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PrdlstServiceImpl implements PrdlstService{
	
	@Autowired
	private PrdlstMapper prdlstMapper;
	
	private String uploadPath = "C:/upload";
	
	@Override
	public List<String> getUnitList() {
		return prdlstMapper.getUnitList();
	}

	@Override
	public List<PrdlstCtgryVO> getLevelOneCtgryList() {
		return prdlstMapper.getLevelOneCtgryList();
	}

	@Override
	public List<PrdlstCtgryVO> getLevelTwoCtgryList(int levelOneCtgryNo) {
		return prdlstMapper.getLevelTwoCtgryList(levelOneCtgryNo);
	}

	@Override
	public List<PrdlstCtgryVO> getLevelThreeCtgryList(int levelTwoCtgryNo) {
		return prdlstMapper.getLevelThreeCtgryList(levelTwoCtgryNo);
	}

	@Override
	public int getCcpyCount(PaginationInfoVO<CooperationcomVO> pagingVO) {
		return prdlstMapper.getCcpyCount(pagingVO);
	}

	@Override
	public List<CooperationcomVO> getCcpyList(PaginationInfoVO<CooperationcomVO> pagingVO) {
		return prdlstMapper.getCcpyList(pagingVO);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int prdlstRegister(PrdlstVO prdlstVO) {
		int registerStatus = prdlstMapper.prdlstRegister(prdlstVO);
		
		if (registerStatus == 1) {
            // 품목 이미지가 저장될 경로
        	// c:/upload/profile/emplCode/emplCode.fileExtension
            String prdlstUploadPath = uploadPath + "/prdlst/" + prdlstVO.getPrdlstNo();
            File uploadDir = new File(prdlstUploadPath);

            // 폴더가 없다면 생성
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            MultipartFile imageFile = prdlstVO.getPrdlstImage();

            // 프로필 사진이 존재하는지 확인
            if (imageFile != null && !imageFile.getOriginalFilename().isEmpty()) {
            	
                try {
                    String originalFilename = imageFile.getOriginalFilename();
                    String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));	// 파일 확장자
                    
                    String newFileName = prdlstVO.getPrdlstNo() + fileExtension;
                    // 저장될 파일의 전체 경로 생성
                    File saveProfileImage = new File(prdlstUploadPath, newFileName);

                    // 파일 저장
                    imageFile.transferTo(saveProfileImage);
                    
                    // 저장된 파일 경로를 DB에 업데이트
                    String filePathForDB = "/upload/prdlst/" + prdlstVO.getPrdlstNo() + "/" + newFileName;
                    prdlstVO.setPrdlstImageCours(filePathForDB);
                    int imageCoursUpdateStatus = prdlstMapper.setPrdlstImageCours(prdlstVO);
                    
                    log.info("프로필 이미지 저장 완료: " + filePathForDB);

                } catch (IllegalStateException | IOException e) {
                    log.error("파일 저장 중 오류 발생:", e);
                    throw new RuntimeException("파일 저장 실패", e);  // 트랜잭션 롤백을 위해 예외 발생
                }
            }
        }
        return registerStatus;
	}

	@Override
	public PrdlstVO getPrdlstByPrdlstNo(int prdlstNo) {
		return prdlstMapper.getPrdlstByPrdlstNo(prdlstNo);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int prdlstModify(PrdlstVO prdlstVO) {
		
		int modifyStatus = prdlstMapper.prdlstModify(prdlstVO);
		MultipartFile imageFile = prdlstVO.getPrdlstImage();
		
		
		if (modifyStatus == 1 && imageFile != null && !imageFile.isEmpty()) {
			File originFilePath = new File("C:/upload/prdlst/" + prdlstVO.getPrdlstNo());
			
			// 기존 프로필 이미지 경로가 있는지 확인하고
			if (originFilePath.exists()) {
				// 기존 프로필 이미지가 있는경우 해당 디렉토리를 비운다.
				try {
					FileUtils.cleanDirectory(originFilePath);
				} catch (IOException e) {
					log.error("[modifyPrdlst ERROR - 디렉토리 클린 오류]", e);
				}
				
				try {
					// 파일 확장자 얻기
                    String originalFilename = imageFile.getOriginalFilename();
                    String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));	// 파일 확장자
                    
                    // emplCode + 파일 확장자 명으로 이름을 생성
                    String newFileName = prdlstVO.getPrdlstNo() + fileExtension;
                    
                    // 저장될 파일의 전체 경로 생성
                    File saveProfileImage = new File(originFilePath, newFileName);

                    // 파일 저장
                    imageFile.transferTo(saveProfileImage);
                    
                    // 저장된 파일 경로를 DB에 업데이트
                    String filePathForDB = "/upload/prdlst/" + prdlstVO.getPrdlstNo() + "/" + newFileName;
                    prdlstVO.setPrdlstImageCours(filePathForDB);
                    prdlstMapper.setPrdlstImageCours(prdlstVO);
                    log.info("품목 이미지 수정 완료: " + filePathForDB);
                } catch (IllegalStateException | IOException e) {
                    log.error("파일 저장 중 오류 발생:", e);
                    throw new RuntimeException("파일 저장 실패", e);  // 트랜잭션 롤백을 위해 예외 발생
                }
			}
		}
		return modifyStatus;	
	}

	@Override
	public int getPrdlstCount(PrdlstSearchVO prdlstSearchVO) {
		return prdlstMapper.getPrdlstCount(prdlstSearchVO);
	}

	@Override
	public List<PrdlstVO> getPrdlstList(PaginationInfoVO<PrdlstVO> pagingVO, PrdlstSearchVO prdlstSearchVO) {
		return prdlstMapper.getPrdlstList(pagingVO, prdlstSearchVO);
	}
	

}
