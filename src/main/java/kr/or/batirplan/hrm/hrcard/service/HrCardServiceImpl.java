package kr.or.batirplan.hrm.hrcard.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import kr.or.batirplan.hrm.hrcard.mapper.HrCardMapper;
import kr.or.batirplan.hrm.hrcard.vo.HrCardSearchVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class HrCardServiceImpl implements HrCardService{
	
	@Autowired
	private HrCardMapper mapper;
	
	private String uploadPath = "C:/upload";
	
 	@Override
    @Transactional(rollbackFor = Exception.class)
    public int insertEmployee(EmployeeVO employeeVO) {
        int status = mapper.insertEmployee(employeeVO);

        // 회원 정보가 Insert 성공시 파일을 저장.
        if (status == 1) {
            // 프로필 이미지가 저장될 경로
        	// c:/upload/profile/emplCode/emplCode.fileExtension
            String profileUploadPath = uploadPath + "/profile/" + employeeVO.getEmplCode();
            File uploadDir = new File(profileUploadPath);

            // 폴더가 없다면 생성
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            MultipartFile profileImage = employeeVO.getEmplProfile();

            // 프로필 사진이 존재하는지 확인
            if (profileImage != null && !profileImage.getOriginalFilename().isEmpty()) {
            	
                try {
                    String originalFilename = profileImage.getOriginalFilename();
                    String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));	// 파일 확장자
                    
                    String newFileName = employeeVO.getEmplCode() + fileExtension;
                    // 저장될 파일의 전체 경로 생성
                    File saveProfileImage = new File(profileUploadPath, newFileName);

                    // 파일 저장
                    profileImage.transferTo(saveProfileImage);
                    
                    // 저장된 파일 경로를 DB에 업데이트
                    String filePathForDB = "/upload/profile/" + employeeVO.getEmplCode() + "/" + newFileName;
                    employeeVO.setProflImageCours(filePathForDB);
                    int profileImageStatus = mapper.setEmployeEmplImageCours(employeeVO);
                    
                    log.info("프로필 이미지 저장 완료: " + filePathForDB);

                } catch (IllegalStateException | IOException e) {
                    log.error("파일 저장 중 오류 발생:", e);
                    throw new RuntimeException("파일 저장 실패", e);  // 트랜잭션 롤백을 위해 예외 발생
                }
            }
        }
        return status;
    }

	@Override
	public EmployeeVO getEmployeeByEmplCode(String emplCode) {
		return mapper.getEmployeeByEmplCode(emplCode);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int modifyEmployee(EmployeeVO employeeVO) {
		
		int modifyStatus = mapper.modifyEmployee(employeeVO);
		MultipartFile profileImage = employeeVO.getEmplProfile();
		
		// 넘어온 정보를 기준으로 회원 정보를 수정했고 멀티파트파일이 존재한다면 -> 프로필 이미지 수정
		if (modifyStatus == 1 && profileImage != null && !profileImage.isEmpty()) {
			// 기존 프로필 이미지 경로
			File originFilePath = new File("C:/upload/profile/" + employeeVO.getEmplCode());
			
			// 기존 프로필 이미지 경로가 있는지 확인하고
			if (originFilePath.exists()) {
				// 기존 프로필 이미지가 있는경우 해당 디렉토리를 비운다.
				try {
					FileUtils.cleanDirectory(originFilePath);
				} catch (IOException e) {
					log.error("[modifyEmployee ERROR - 디렉토리 클린 오류]", e);
				}
				
				try {
					// 파일 확장자 얻기
                    String originalFilename = profileImage.getOriginalFilename();
                    String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));	// 파일 확장자
                    
                    // emplCode + 파일 확장자 명으로 이름을 생성
                    String newFileName = employeeVO.getEmplCode() + fileExtension;
                    
                    // 저장될 파일의 전체 경로 생성
                    File saveProfileImage = new File(originFilePath, newFileName);

                    // 파일 저장
                    profileImage.transferTo(saveProfileImage);
                    
                    // 저장된 파일 경로를 DB에 업데이트
                    String filePathForDB = "/upload/profile/" + employeeVO.getEmplCode() + "/" + newFileName;
                    employeeVO.setProflImageCours(filePathForDB);
                    int profileImageStatus = mapper.setEmployeEmplImageCours(employeeVO);
                    
                    log.info("프로필 이미지 수정 완료: " + filePathForDB);
                } catch (IllegalStateException | IOException e) {
                    log.error("파일 저장 중 오류 발생:", e);
                    throw new RuntimeException("파일 저장 실패", e);  // 트랜잭션 롤백을 위해 예외 발생
                }
			} else {
	            // 프로필 이미지가 저장될 경로
	        	// c:/upload/profile/emplCode/emplCode.fileExtension
	            String profileUploadPath = uploadPath + "/profile/" + employeeVO.getEmplCode();
	            File uploadDir = new File(profileUploadPath);

	            // 폴더가 없다면 생성
	            if (!uploadDir.exists()) {
	                uploadDir.mkdirs();
	            }

	            // 프로필 사진이 존재하는지 확인
	            if (profileImage != null && !profileImage.getOriginalFilename().isEmpty()) {
	            	
	                try {
	                    String originalFilename = profileImage.getOriginalFilename();
	                    String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));	// 파일 확장자
	                    
	                    String newFileName = employeeVO.getEmplCode() + fileExtension;
	                    // 저장될 파일의 전체 경로 생성
	                    File saveProfileImage = new File(profileUploadPath, newFileName);

	                    // 파일 저장
	                    profileImage.transferTo(saveProfileImage);
	                    
	                    // 저장된 파일 경로를 DB에 업데이트
	                    String filePathForDB = "/upload/profile/" + employeeVO.getEmplCode() + "/" + newFileName;
	                    employeeVO.setProflImageCours(filePathForDB);
	                    int profileImageStatus = mapper.setEmployeEmplImageCours(employeeVO);
	                    
	                    log.info("프로필 이미지 저장 완료: " + filePathForDB);

	                } catch (IllegalStateException | IOException e) {
	                    log.error("파일 저장 중 오류 발생:", e);
	                    throw new RuntimeException("파일 저장 실패", e);  // 트랜잭션 롤백을 위해 예외 발생
	                }
	            }
				
			}
			
			
		}
		return mapper.modifyEmployee(employeeVO);
	}

	@Override
	public List<EmployeeVO> getEmployeeList(HrCardSearchVO searchVO, PaginationInfoVO<EmployeeVO> pagingVO) {
		return mapper.getEmployeeList(searchVO, pagingVO);
	}

	@Override
	public int getEmployeeCount(HrCardSearchVO searchVO) {
		return mapper.getEmployeeCount(searchVO);
	}

	@Override
	public int emplRetireProcess(String emplCode) {
		return mapper.emplRetireProcess(emplCode);
	}
	
	
}
