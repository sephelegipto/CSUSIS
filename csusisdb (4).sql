-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 23, 2018 at 07:43 AM
-- Server version: 5.7.21-log
-- PHP Version: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `csusisdb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`192.168.1.177` PROCEDURE `spCheckListAddOREdit` (`AESwitch` INT(11), `CID` INT(11), `SID` INT(11), `LBU` VARCHAR(20), `LCU` VARCHAR(20), `LBH` VARCHAR(20), `LCH` VARCHAR(20), `SYI` INT(11), `STI` INT(11), `ST` VARCHAR(20))  BEGIN
IF (AESwitch = 0) then
	IF (SELECT COUNT(ID) FROM tChecklists WHERE CurriculumID=CID 
		AND SubjectID = SID ) = 0 THEN
		INSERT INTO tChecklists(CurriculumID,SubjectID,LabUnits,LecUnits,LabHours,LecHours,SubjectYearID,SubjectTermID,SubjectType)
        VALUES (CID,SID,LBU,LCU,LBH,LCH,SYI,STI,ST);
	END IF;
else
	IF (SELECT COUNT(ID) FROM tChecklists WHERE CurriculumID=CID 
		AND SubjectID = SID 
		AND Labunits=LBU 
		AND LecUnits=LCU 
		AND LabHours=LBH 
		AND LecHours=LCH 
		AND SubjectYearID=SYI 
		AND SubjectTermID=STI 
		AND SubjectType=ST) = 0 THEN
		Update tChecklists SET CurriculumID=CID,SubjectID=SID,LabUnits=LBU,LecUnits=LCU,LabHours=LBH,LecHours=LCH,SubjectYearID=SYI,SubjectTermID=STI,SubjectType=ST
        WHERE ID=AeSwitch;
	END IF;
END IF;
END$$

CREATE DEFINER=`root`@`192.168.1.177` PROCEDURE `spChecklistsViewAllORSearch` (`LibraryToLoad` VARCHAR(50), `SearchText` VARCHAR(50), `SearchCode` VARCHAR(50), `SubjectYear` VARCHAR(20), `TD` VARCHAR(20))  BEGIN
CASE LibraryToLoad
	WHEN "Subject Details" THEN
		SELECT * FROM vChecklists WHERE CurriculumCode=SearchCode AND SubjectYearDescription=SubjectYear AND TermDescription=TD AND(SearchText = '' 
		OR SubjectCode LIKE  CONCAT('%',SearchText , '%')
		OR SubjectDescription LIKE  CONCAT('%',SearchText , '%')
		OR Units LIKE  CONCAT('%',SearchText , '%')
		OR SubjectYearDescription LIKE  CONCAT('%',SearchText , '%')
		OR TermDescription LIKE  CONCAT('%',SearchText , '%')
		OR PreRequisiteCODE LIKE  CONCAT('%',SearchText , '%'));
	WHEN "Subjects" THEN
    SELECT * FROM vChecklists WHERE CurriculumCode=SearchCode AND (SearchText = '' 
		OR SubjectCode LIKE  CONCAT('%',SearchText , '%')
		OR SubjectDescription LIKE  CONCAT('%',SearchText , '%')
		OR Units LIKE  CONCAT('%',SearchText , '%')
		OR SubjectYearDescription LIKE  CONCAT('%',SearchText , '%')
		OR TermDescription LIKE  CONCAT('%',SearchText , '%')
		OR PreRequisiteCODE LIKE  CONCAT('%',SearchText , '%'))
        ORDER BY SubjectDescription,SubjectCode;
END CASE;
END$$

CREATE DEFINER=`root`@`192.168.1.177` PROCEDURE `spCitiesFeesAddOREdit` (`AESwitch` INT(11), `LibraryToAddEdit` VARCHAR(45), `ParamCode` VARCHAR(50), `ParamDescription` VARCHAR(100), `ParamSelector` VARCHAR(50))  BEGIN
IF (AESwitch = 0) then
	CASE LibraryToAddEdit
		WHEN 'Add City' THEN
			IF (SELECT COUNT(ID) FROM tCities WHERE CityCode=ParamCode AND CityDescription = ParamDescription AND Region=ParamSelector) = 0 THEN
				INSERT INTO tCities(CityCode, CityDescription, Region) VALUES (ParamCode, ParamDescription,ParamSelector);
			END IF;
        WHEN 'Add Fee' THEN
			IF (SELECT COUNT(ID) FROM tFees WHERE FeeCode=ParamCode AND FeeDescription = ParamDescription AND FeeCategory=ParamSelector) = 0 THEN
				INSERT INTO tFees(FeeCode, FeeDescription, FeeCategory) VALUES (ParamCode, ParamDescription,ParamSelector);
			END IF;
	END CASE;
else
	CASE LibraryToAddEdit
		WHEN 'Edit City' THEN
			IF (SELECT COUNT(ID) FROM tCities WHERE CityCode=ParamCode AND CityDescription = ParamDescription AND Region=ParamSelector) = 0 THEN
				UPDATE tCities SET CityCode=ParamCode, CityDescription=ParamDescription, Region=ParamSelector
				WHERE ID=AESwitch;
			END IF;
        WHEN 'Edit Fee' THEN
			IF (SELECT COUNT(ID) FROM tFees WHERE FeeCode=ParamCode AND FeeDescription = ParamDescription AND FeeCategory=ParamSelector) = 0 THEN
				UPDATE tFees SET FeeCode=ParamCode, FeeDescription=ParamDescription, FeeCategory=ParamSelector
				WHERE ID=AESwitch;
			END IF;
	END CASE;
END IF;
END$$

CREATE DEFINER=`root`@`192.168.1.177` PROCEDURE `spCoursesAddOREdit` (`AESwitch` INT(11), `LibraryToAddEdit` VARCHAR(45), `ParamCode` VARCHAR(50), `ParamDescription` VARCHAR(100), `DID` INT(11), `MID` INT(11), `NOY` INT(11), `LVL` VARCHAR(50))  BEGIN
IF (AESwitch = 0) then
	CASE LibraryToAddEdit
		WHEN 'Add Course' THEN
			IF (SELECT COUNT(ID) FROM tCourses WHERE CourseCode=ParamCode AND CourseTitle = ParamDescription AND CollegeID=DID AND MajorID=MID AND NoOfYears=NOY AND EducationLevel=LVL) = 0 THEN
				INSERT INTO tCourses(CourseCode,CourseTitle,CollegeID,MajorID,NoOfYears,EducationLevel) VALUES (ParamCode, ParamDescription,DID,MID,NOY,LVL);
			END IF;
	END CASE;
else
	CASE LibraryToAddEdit
		WHEN 'Edit Course' THEN
			IF (SELECT COUNT(ID) FROM tCourses WHERE CourseCode=ParamCode AND CourseTitle = ParamDescription AND CollegeID=DID AND MajorID=MID AND NoOfYears=NOY AND EducationLevel=LVL) = 0 THEN
					UPDATE tCourses SET CourseCode=ParamCode,CourseTitle=ParamDescription,CollegeID=DID,MajorID=MID,NoOfYears=NOY,EducationLevel=LVL
                    WHERE ID=AESwitch;
			END IF;
	END CASE;
END IF;
END$$

CREATE DEFINER=`root`@`192.168.1.177` PROCEDURE `spCurriculumsAddOREdit` (`AESwitch` INT(11), `CurCode` VARCHAR(50), `CID` INT(11), `EY` INT(11))  BEGIN
IF (AESwitch = 0) then
	IF (SELECT COUNT(ID) FROM tCurriculums WHERE CurriculumCode=CurCode AND CourseID = CID AND EntryYear=EY) = 0 THEN
		INSERT INTO tCurriculums(CurriculumCode, CourseID, EntryYear) VALUES (CurCode, CID,EY);
	END IF;
ELSE
	IF (SELECT COUNT(ID) FROM tCurriculums WHERE CurriculumCode=CurCode AND CourseID = CID AND EntryYear=EY) = 0 THEN
		UPDATE tCurriculums SET CurriculumCode=CurCode, CourseID=CID, EntryYear=EY WHERE ID=AESwitch;
	END IF;
END IF;
END$$

CREATE DEFINER=`root`@`192.168.1.177` PROCEDURE `spCurriculumsViewAllORSearch` (`SearchText` VARCHAR(50))  BEGIN
	SELECT * FROM vCurriculums WHERE SearchText = '' 
	OR CurriculumCode LIKE  CONCAT('%',SearchText , '%')
    OR EntryYear LIKE  CONCAT('%',SearchText , '%')
	OR CourseTitle LIKE  CONCAT('%',SearchText , '%')
    OR CollegeCode LIKE  CONCAT('%',SearchText , '%')
    OR CollegeDescription LIKE  CONCAT('%',SearchText , '%')
    OR MajorCode LIKE  CONCAT('%',SearchText , '%')
    OR MajorDescription LIKE  CONCAT('%',SearchText , '%')
    OR NoOfYears LIKE  CONCAT('%',SearchText , '%')
    OR EducationLevel LIKE  CONCAT('%',SearchText , '%')
	order by CourseTitle;
END$$

CREATE DEFINER=`root`@`192.168.1.177` PROCEDURE `spDepartmentsCollegesAddOREdit` (`AESwitch` INT(11), `LibraryToAddEdit` VARCHAR(45), `ParamCode` VARCHAR(50), `ParamDescription` VARCHAR(100), `ParamHead` INT(11))  BEGIN
IF (AESwitch = 0) then
	CASE LibraryToAddEdit
		WHEN 'Add Department' THEN
			IF (SELECT COUNT(ID) FROM tDepartments WHERE DepartmentCode=ParamCode AND DepartmentDescription = ParamDescription AND DepartmentHead=ParamHead) = 0 THEN
				INSERT INTO tDepartments(DepartmentCode, DepartmentDescription, DepartmentHead) VALUES (ParamCode, ParamDescription,ParamHead);
			END IF;
        WHEN 'Add College' THEN
			IF (SELECT COUNT(ID) FROM tColleges WHERE CollegeCode=ParamCode AND CollegeDescription = ParamDescription AND CollegeHead=ParamHead) = 0 THEN
				INSERT INTO tColleges(CollegeCode, CollegeDescription, CollegeHead) VALUES (ParamCode, ParamDescription,ParamHead);
			END IF;
	END CASE;
else
	CASE LibraryToAddEdit
		WHEN 'Edit Department' THEN
			IF (SELECT COUNT(ID) FROM tDepartments WHERE DepartmentCode=ParamCode AND DepartmentDescription = ParamDescription AND DepartmentHead=ParamHead) = 0 THEN
				UPDATE tDepartments SET DepartmentCode=ParamCode, DepartmentDescription=ParamDescription, DepartmentHead=ParamHead
                WHERE ID=AESwitch;
			END IF;
        WHEN 'Edit College' THEN
			IF (SELECT COUNT(ID) FROM tColleges WHERE CollegeCode=ParamCode AND CollegeDescription = ParamDescription AND CollegeHead=ParamHead) = 0 THEN
				UPDATE tColleges SET CollegeCode=ParamCode, CollegeDescription=ParamDescription, CollegeHead=ParamHead
                WHERE ID=AESwitch;
			END IF;
	END CASE;
END IF;
END$$

CREATE DEFINER=`root`@`192.168.1.177` PROCEDURE `spEmployeesAddOREdit` (`AESwitch` INT(11), `EID` VARCHAR(45), `Sal` VARCHAR(45), `LN` VARCHAR(45), `FN` VARCHAR(45), `MN` VARCHAR(45), `PID` INT(11), `DID` INT(11), `Gen` VARCHAR(10), `FID` INT(11), `SID` INT(11), `CID` INT(11), `STATUSID` VARCHAR(50), `Address` VARCHAR(200))  BEGIN
IF (AESwitch = 0) then
	IF (SELECT COUNT(ID) FROM vEmployees WHERE EmployeeID=EID) = 0 THEN
		INSERT INTO tEmployees(EmployeeID, Salutation, LastName, FirstName, MiddleName, PositionID, DepartmentID, Gender,FacultyRankID,SalaryGradeID,CollegeID,Status,Address)
		VALUES (EID, Sal, LN, FN, MN, PID, DID, GEN,FID,SID,CID,STATUSID,Address);
	END IF;
ELSE
		UPDATE tEmployees SET Salutation=Sal,EmployeeID=EID, LastName=LN, FirstName=FN, MiddleName=MN , PositionID=PID, DepartmentID=DID, Gender=GEN,
        FacultyRankID=FID,SalaryGradeID=SID,CollegeID=CID,Status=STATUSID,Address=Address WHERE ID = AESwitch;
END IF;
END$$

CREATE DEFINER=`root`@`192.168.1.177` PROCEDURE `spEmployeesImageAddOREdit` (`AESwitch` INT(11), `EID` VARCHAR(45), `imgByteArray` MEDIUMBLOB, `ImageID` INT(11))  BEGIN
IF (AESwitch = 0) then
	IF (SELECT COUNT(EmployeeID) FROM tImages WHERE EmployeeID=EID) = 0 THEN
		INSERT INTO tImages(EmployeeID,ProfilePicture)
		VALUES (EID,imgByteArray);
	END IF;
ELSE
        UPDATE tImages SET EmployeeID=EID, ProfilePicture=imgByteArray
		WHERE ID=ImageID;
END IF;
END$$

CREATE DEFINER=`root`@`192.168.1.177` PROCEDURE `spLibraryAddOREdit` (`AESwitch` INT(50), `LibraryToAddEdit` VARCHAR(50), `ParamCode` VARCHAR(50), `ParamDescription` VARCHAR(100))  BEGIN
	IF (AESwitch = 0) then
		CASE LibraryToAddEdit
			WHEN 'Add Position' THEN
				IF (SELECT COUNT(ID) FROM tpositions WHERE PositionCode=ParamCode AND PositionDescription = ParamDescription) = 0 THEN
					INSERT INTO tpositions(PositionCode, PositionDescription) VALUES (ParamCode, ParamDescription);
                END IF;
			WHEN 'Add Major' THEN
				IF (SELECT COUNT(ID) FROM tMajors WHERE MajorCode=ParamCode AND MajorDescription=ParamDescription) = 0 THEN
					INSERT INTO tMajors(MajorCode, MajorDescription)VALUES (ParamCode, ParamDescription);
                END IF;
			WHEN 'Add Nationality' THEN
				IF (SELECT COUNT(ID) FROM tNationalities WHERE NationalityCode=ParamCode AND NationalityDescription=ParamDescription) = 0 THEN
					INSERT INTO tNationalities(NationalityCode, NationalityDescription)VALUES (ParamCode, ParamDescription);
                END IF;
			WHEN 'Add Religion' THEN
				IF (SELECT COUNT(ID) FROM tReligions WHERE ReligionCode=ParamCode AND ReligionDescription=ParamDescription) = 0 THEN
					INSERT INTO tReligions(ReligionCode, ReligionDescription)VALUES (ParamCode, ParamDescription);
                END IF;
			WHEN 'Add Scholarship' THEN
				IF (SELECT COUNT(ID) FROM tScholarships WHERE ScholarshipCode=ParamCode AND ScholarshipDescription=ParamDescription) = 0 THEN
					INSERT INTO tScholarships(ScholarshipCode, ScholarshipDescription)VALUES (ParamCode, ParamDescription);
                END IF;
			WHEN 'Add School' THEN
				IF (SELECT COUNT(ID) FROM tSchools WHERE SchoolCode=ParamCode AND SchoolDescription=ParamDescription) = 0 THEN
					INSERT INTO tSchools(SchoolCode, SchoolDescription)VALUES (ParamCode, ParamDescription);
                END IF;
			WHEN 'Add Building' THEN
				IF (SELECT COUNT(ID) FROM tBuildings WHERE BuildingCode=ParamCode AND BuildingDescription=ParamDescription) = 0 THEN
					INSERT INTO tBuildings(BuildingCode, BuildingDescription)VALUES (ParamCode, ParamDescription);
                END IF;
			WHEN 'Add Faculty Rank' THEN
				IF (SELECT COUNT(ID) FROM tFacultyRanks WHERE RankCode=ParamCode AND RankDescription = ParamDescription) = 0 THEN
					INSERT INTO tFacultyRanks(RankCode, RankDescription) VALUES (ParamCode, ParamDescription);
                END IF;
			WHEN 'Add Salary Grade' THEN
				IF (SELECT COUNT(ID) FROM tSalaryGrades WHERE GradeCode=ParamCode AND GradeDescription = ParamDescription) = 0 THEN
					INSERT INTO tSalaryGrades(GradeCode, GradeDescription) VALUES (ParamCode, ParamDescription);
                END IF;
        END CASE;
	ELSE
		CASE LibraryToAddEdit
			WHEN 'Edit Position' THEN
				IF (SELECT COUNT(ID) FROM tpositions WHERE PositionCode=ParamCode AND PositionDescription=ParamDescription ) = 0 THEN
					UPDATE tpositions SET PositionCode=ParamCode, PositionDescription=ParamDescription WHERE ID = AESwitch;
				END IF;
			WHEN 'Edit Major' THEN
				IF (SELECT COUNT(ID) FROM tmajors WHERE MajorCode=ParamCode AND MajorDescription=ParamDescription) = 0 THEN
					UPDATE tmajors SET MajorCode=ParamCode, MajorDescription=ParamDescription WHERE ID = AESwitch;
				END IF;
			WHEN 'Edit Nationality' THEN
				IF (SELECT COUNT(ID) FROM tnationalities WHERE NationalityCode=ParamCode AND NationalityDescription=ParamDescription) = 0 THEN
					UPDATE tnationalities SET NationalityCode=ParamCode, NationalityDescription=ParamDescription WHERE ID = AESwitch;
                END IF;
			WHEN 'Edit Religion' THEN
				IF (SELECT COUNT(ID) FROM treligions WHERE ReligionCode=ParamCode AND ReligionDescription=ParamDescription) = 0 THEN
					UPDATE treligions SET ReligionCode=ParamCode, ReligionDescription=ParamDescription WHERE ID = AESwitch;
				END IF;
			WHEN 'Edit Scholarship' THEN
				IF (SELECT COUNT(ID) FROM tscholarships WHERE ScholarshipCode=ParamCode AND ScholarshipDescription=ParamDescription) = 0 THEN
					UPDATE tscholarships SET ScholarshipCode=ParamCode, ScholarshipDescription=ParamDescription WHERE ID = AESwitch;
				END IF;
			WHEN 'Edit School' THEN
				IF (SELECT COUNT(ID) FROM tschools WHERE SchoolCode=ParamCode AND SchoolDescription=ParamDescription) = 0 THEN
					UPDATE tschools SET SchoolCode=ParamCode, SchoolDescription=ParamDescription WHERE ID = AESwitch;
				END IF;
			WHEN 'Edit Building' THEN
				IF (SELECT COUNT(ID) FROM tBuildings WHERE BuildingCode=ParamCode AND BuildingDescription=ParamDescription) = 0 THEN
					UPDATE tbuildings SET BuildingCode=ParamCode, BuildingDescription=ParamDescription WHERE ID = AESwitch;
				END IF;
			WHEN 'Edit Faculty Rank' THEN
				IF (SELECT COUNT(ID) FROM tFacultyRanks WHERE RankCode=ParamCode AND RankDescription = ParamDescription) = 0 THEN
					UPDATE tFacultyRanks SET RankCode=ParamCode, RankDescription=ParamDescription WHERE ID = AESwitch;
                END IF;
			WHEN 'Edit Salary Grade' THEN
				IF (SELECT COUNT(ID) FROM tBuildings WHERE BuildingCode=ParamCode AND BuildingDescription=ParamDescription) = 0 THEN
					UPDATE tSalaryGrades SET GradeCode=ParamCode, GradeDescription=ParamDescription WHERE ID = AESwitch;
				END IF;
        END CASE;
	END if;
END$$

CREATE DEFINER=`root`@`192.168.1.177` PROCEDURE `spLibraryDeletebyID` (`IDToDelete` INT, `LibraryToDelete` VARCHAR(50))  BEGIN
	CASE LibraryToDelete
		WHEN 'Positions' THEN
			DELETE from tPositions WHERE ID = IDToDelete;
		WHEN 'Departments' THEN
			DELETE from tDepartments WHERE ID = IDToDelete;	
		WHEN 'Majors' THEN
			DELETE from tMajors WHERE ID = IDToDelete;	
		WHEN 'Nationalitys' THEN
			DELETE from tNationalities WHERE ID = IDToDelete;		
		WHEN 'Religions' THEN
			DELETE from tReligions WHERE ID = IDToDelete;		
		WHEN 'Scholarships' THEN
			DELETE from tScholarships WHERE ID = IDToDelete;		
		WHEN 'Schools' THEN
			DELETE from tSchools WHERE ID = IDToDelete;		
		WHEN 'Buildings' THEN
			DELETE from tBuildings WHERE ID = IDToDelete;	
		WHEN 'Employees' THEN
			DELETE from tEmployees WHERE ID = IDToDelete;	
		WHEN 'Cities' THEN
			DELETE from tCities WHERE ID = IDToDelete;	
		WHEN 'Courses' THEN
			DELETE from tCourses WHERE ID = IDToDelete;	
		WHEN 'Fees' THEN
			DELETE from tFees WHERE ID = IDToDelete;	
		WHEN 'Rooms' THEN
			DELETE from tRooms WHERE ID = IDToDelete;	
		WHEN 'Subjects' THEN	
			DELETE from tSubjects WHERE ID = IDToDelete;	
		WHEN 'Salary Grades' THEN
			DELETE from tSalaryGrades WHERE ID = IDToDelete;
		WHEN 'Faculty Ranks' THEN
			DELETE from tFacultyRanks WHERE ID = IDToDelete;
		WHEN 'Colleges' THEN
			DELETE from tColleges WHERE ID = IDToDelete;
		WHEN 'Curriculums' THEN
			DELETE from tCurriculums WHERE ID = IDToDelete;
END CASE;
END$$

CREATE DEFINER=`root`@`192.168.1.177` PROCEDURE `spLibraryViewAllORSearch` (`LibraryToLoad` VARCHAR(50), `SearchText` VARCHAR(50))  BEGIN
	CASE LibraryToLoad
		WHEN 'Employees' then
			SELECT *, Concat(Salutation , ' ', FirstName , ' ',MiddleName , ' ', LastName) as FullName FROM vEmployees WHERE SearchText = '' 
            OR EmployeeID LIKE  CONCAT('%',SearchText , '%')
            OR Salutation LIKE  CONCAT('%',SearchText , '%')
            OR LastName LIKE  CONCAT('%',SearchText , '%')
            OR FirstName LIKE  CONCAT('%',SearchText , '%')
            OR MiddleName LIKE  CONCAT('%',SearchText , '%')
            OR PositionCode LIKE  CONCAT('%',SearchText , '%')
            OR PositionDescription LIKE  CONCAT('%',SearchText , '%')
            OR DepartmentCode LIKE  CONCAT('%',SearchText , '%')
            OR DepartmentDescription LIKE  CONCAT('%',SearchText , '%')
            OR Gender LIKE  CONCAT('%',SearchText , '%')
            OR Status LIKE  CONCAT('%',SearchText , '%')
            OR RankCode LIKE  CONCAT('%',SearchText , '%')
            OR RankDescription LIKE  CONCAT('%',SearchText , '%') 
            OR GradeCode LIKE  CONCAT('%',SearchText , '%')
            OR GradeDescription LIKE  CONCAT('%',SearchText , '%')
            OR CollegeCode LIKE  CONCAT('%',SearchText , '%')
            OR CollegeDescription LIKE  CONCAT('%',SearchText , '%')
			OR Address LIKE  CONCAT('%',SearchText , '%')
            order by LastName, MiddleName, FirstName;
		WHEN 'Positions' then
            SELECT * FROM tPositions WHERE SearchText = '' 
            OR PositionCode LIKE  CONCAT('%',SearchText , '%')
            OR PositionDescription LIKE  CONCAT('%',SearchText , '%')
            order by PositionDescription;
		When 'Departments' then
            SELECT * FROM vDepartments WHERE SearchText = '' 
            OR DepartmentCode LIKE  CONCAT('%',SearchText , '%')
			OR DepartmentDescription LIKE  CONCAT('%',SearchText , '%')
            OR DepartmentHead LIKE  CONCAT('%',SearchText , '%')
            order by DepartmentDescription;
		When 'Colleges' then
            SELECT * FROM vColleges WHERE SearchText = '' 
            OR CollegeCode LIKE  CONCAT('%',SearchText , '%')
			OR CollegeDescription LIKE  CONCAT('%',SearchText , '%')
            OR CollegeHead LIKE  CONCAT('%',SearchText , '%')
            order by CollegeDescription;
		When 'Majors' then
            SELECT * FROM tMajors WHERE SearchText = ''
            OR MajorCode LIKE  CONCAT('%',SearchText , '%')
            OR MajorDescription LIKE  CONCAT('%',SearchText , '%')
            order by MajorDescription;
		WHEN'Nationalities' then
			SELECT * FROM tNationalities WHERE SearchText = '' 
            OR NationalityCode LIKE  CONCAT('%',SearchText , '%') 
            OR NationalityDescription LIKE  CONCAT('%',SearchText , '%')
            order by NationalityDescription;
		WHEN'Religions' then
			SELECT * FROM tReligions WHERE SearchText = '' 
            OR ReligionCode LIKE  CONCAT('%',SearchText , '%')
			OR ReligionDescription LIKE  CONCAT('%',SearchText , '%')
            order by ReligionDescription;
		WHEN'Scholarships' then
			SELECT * FROM tScholarships WHERE SearchText = ''
            OR ScholarshipCode LIKE  CONCAT('%',SearchText , '%')
            OR ScholarshipDescription LIKE  CONCAT('%',SearchText , '%')
            order by ScholarshipDescription;
		WHEN'Schools' then
			SELECT * FROM tSchools WHERE SearchText = ''
            OR SchoolCode LIKE  CONCAT('%',SearchText , '%')
            OR SchoolDescription LIKE  CONCAT('%',SearchText , '%')
            order by SchoolDescription;
		WHEN'Buildings' then
			SELECT * FROM tBuildings WHERE SearchText = ''
            OR BuildingCode LIKE  CONCAT('%',SearchText , '%')
            OR BuildingDescription LIKE  CONCAT('%',SearchText , '%')
            order by BuildingDescription;
		WHEN'Cities' then
			SELECT * FROM tCities WHERE SearchText = ''
            OR CityCode LIKE  CONCAT('%',SearchText , '%')
            OR CityDescription LIKE  CONCAT('%',SearchText , '%')
            OR Region LIKE  CONCAT('%',SearchText , '%')
            order by CityDescription;
		WHEN'Courses' then
			SELECT * FROM vCourses WHERE SearchText = ''
            OR CourseCode LIKE  CONCAT('%',SearchText , '%')
            OR CourseTitle LIKE  CONCAT('%',SearchText , '%')
             OR CollegeCode LIKE  CONCAT('%',SearchText , '%')
            OR CollegeDescription LIKE  CONCAT('%',SearchText , '%')
            OR MajorCode LIKE  CONCAT('%',SearchText , '%')
            OR MajorDescription LIKE  CONCAT('%',SearchText , '%')
            OR NoOfYears LIKE  CONCAT('%',SearchText , '%')
            OR EducationLevel LIKE  CONCAT('%',SearchText , '%')
            order by EducationLevel;
		WHEN'Fees' then
			SELECT * FROM tFees WHERE SearchText = ''
            OR FeeCode LIKE  CONCAT('%',SearchText , '%')
            OR FeeDescription LIKE  CONCAT('%',SearchText , '%')
            OR FeeCategory LIKE  CONCAT('%',SearchText , '%')
            order by FeeDescription;
		WHEN'Rooms' then
			SELECT * FROM vRooms WHERE SearchText = ''
            OR RoomCode LIKE  CONCAT('%',SearchText , '%')
            OR RoomDescription LIKE  CONCAT('%',SearchText , '%')
            OR RoomType LIKE  CONCAT('%',SearchText , '%')
            OR BuildingCode LIKE  CONCAT('%',SearchText , '%')
            OR BuildingDescription LIKE  CONCAT('%',SearchText , '%')
            OR CollegeCode LIKE  CONCAT('%',SearchText , '%')
			OR CollegeDescription LIKE  CONCAT('%',SearchText , '%')
            order by RoomCode, RoomDescription;
		WHEN'Subjects' then
			SELECT * FROM tSubjects WHERE SearchText = ''
            OR SubjectCode LIKE  CONCAT('%',SearchText , '%')
            OR SubjectDescription LIKE  CONCAT('%',SearchText , '%')
            OR Imported LIKE  CONCAT('%',SearchText , '%')
             OR Level LIKE  CONCAT('%',SearchText , '%')
            OR Units LIKE  CONCAT('%',SearchText , '%')
            order by SubjectDescription;
		When 'Faculty Ranks' then
            SELECT * FROM tFacultyRanks WHERE SearchText = ''
            OR RankCode LIKE  CONCAT('%',SearchText , '%')
            OR RankDescription LIKE  CONCAT('%',SearchText , '%')
            order by RankDescription;
		When 'Salary Grades' then
            SELECT * FROM tSalaryGrades WHERE SearchText = ''
            OR GradeCode LIKE  CONCAT('%',SearchText , '%')
            OR GradeDescription LIKE  CONCAT('%',SearchText , '%')
            order by GradeDescription;
		When 'Curriculums' then
			SELECT * FROM vcurriculums WHERE SearchText = ''
			OR CurriculumCode LIKE  CONCAT('%',SearchText , '%')
			OR EntryYear LIKE  CONCAT('%',SearchText , '%')
			OR CourseCode LIKE  CONCAT('%',SearchText , '%')
			OR CourseTitle LIKE  CONCAT('%',SearchText , '%')
			OR CollegeCode LIKE  CONCAT('%',SearchText , '%')
			OR CollegeDescription LIKE  CONCAT('%',SearchText , '%')
			OR MajorCode LIKE  CONCAT('%',SearchText , '%')
			OR MajorDescription LIKE  CONCAT('%',SearchText , '%')
			OR NoOfYears LIKE  CONCAT('%',SearchText , '%')
			OR EducationLevel LIKE  CONCAT('%',SearchText , '%');
        When 'Checklists' then
			SELECT * FROM vchecklists WHERE SearchText = ''
            OR CurriculumID LIKE  CONCAT('%',SearchText , '%')
			order by id;
	END CASE;
    
END$$

CREATE DEFINER=`root`@`192.168.1.177` PROCEDURE `spPreRequisiteAddOREdit` (`AESwitch` INT(11), `CID` INT(11), `SID` INT(11))  BEGIN
IF (AESwitch = 0) then
		INSERT INTO tChecklistPreRequisite(CheckListID,SubjectID)
        VALUES ((Select MAX(ID) from tCheckLists),SID);
else
	IF (SELECT COUNT(ID) FROM tCheckListPreRequisite WHERE CheckListID=CID AND SubjectID=SID)=0 THEN
		UPDATE tChecklistPreRequisite SET CheckListID = CID,SubjectID=SID
        WHERE ID=AWSwitch;
	END IF;
END IF;
END$$

CREATE DEFINER=`root`@`192.168.1.177` PROCEDURE `spRoomsAddOREdit` (`AESwitch` INT(11), `LibraryToAddEdit` VARCHAR(45), `ParamCode` VARCHAR(50), `ParamDescription` VARCHAR(100), `ParamType` VARCHAR(50), `BID` INT(11), `DID` INT(11))  BEGIN
IF (AESwitch = 0) then
	CASE LibraryToAddEdit
		WHEN 'Add Room' THEN
			IF (SELECT COUNT(ID) FROM tRooms WHERE RoomCode=ParamCode AND RoomDescription = ParamDescription AND RoomType=ParamType AND BuildingID=BID AND CollegeID=DID ) = 0 THEN
				INSERT INTO tRooms(RoomCode,RoomDescription,RoomType,BuildingID,CollegeID) VALUES (ParamCode, ParamDescription,Paramtype,BID,DID);
			END IF;
	END CASE;
else
	CASE LibraryToAddEdit
		WHEN 'Edit Room' THEN
			IF (SELECT COUNT(ID) FROM tRooms WHERE RoomCode=ParamCode AND RoomDescription = ParamDescription AND RoomType=ParamType AND BuildingID=BID AND CollegeID=DID ) = 0 THEN
				UPDATE tRooms SET RoomCode=ParamCode,RoomDescription=ParamDescription,RoomType=ParamType,BuildingID=BID,CollegeID=DID
                WHERE ID=AESwitch;
			END IF;
	END CASE;
END IF;
END$$

CREATE DEFINER=`root`@`192.168.1.177` PROCEDURE `spSubjectsAddOREdit` (`AESwitch` INT(11), `LibraryToAddEdit` VARCHAR(45), `ParamCode` VARCHAR(50), `ParamDescription` VARCHAR(100), `ParamLevel` VARCHAR(50), `ParamUnits` VARCHAR(50), `ParamImported` VARCHAR(50))  BEGIN
IF (AESwitch = 0) then
	CASE LibraryToAddEdit
		WHEN 'Add Subject' THEN
			IF (SELECT COUNT(ID) FROM tSubjects WHERE SubjectCode=ParamCode AND SubjectDescription = ParamDescription AND Level=ParamLevel AND Units=ParamUnits AND Imported=ParamImported) = 0 THEN
				INSERT INTO tSubjects(SubjectCode,SubjectDescription,Level,Units,Imported) VALUES (ParamCode, ParamDescription,ParamLevel,ParamUnits,ParamImported);
			END IF;
	END CASE;
else
	CASE LibraryToAddEdit
		WHEN 'Edit Subject' THEN
			IF (SELECT COUNT(ID) FROM tSubjects WHERE SubjectCode=ParamCode AND SubjectDescription = ParamDescription AND Level=ParamLevel AND Units=ParamUnits AND Imported=ParamImported) = 0 THEN
				UPDATE tSubjects SET SubjectCode=ParamCode,SubjectDescription=ParamDescription,Level=ParamLevel,Units=ParamUnits,Imported=ParamImported
                WHERE ID=AESwitch;
			END IF;
	END CASE;
END IF;
END$$

CREATE DEFINER=`root`@`192.168.1.177` PROCEDURE `test` (`AESwitch` INT(11), `EmployeeID` VARCHAR(45), `Salutation` VARCHAR(45), `LastName` VARCHAR(45), `MiddleName` VARCHAR(45), `PositionID` INT(11), `DepartmentID` INT(11), `Gender` VARCHAR(10))  BEGIN
IF (AESwitch = 0) then
SELECT COUNT(ID) FROM vEmployees WHERE EmployeeID=EmployeeID;
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'admin', NULL, NULL),
(2, 'teacher', NULL, NULL),
(3, 'student\r\n', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `samle`
--

CREATE TABLE `samle` (
  `idsamle` int(11) NOT NULL,
  `asd` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `samle`
--

INSERT INTO `samle` (`idsamle`, `asd`) VALUES
(1, 'asda'),
(2, 'asd'),
(3, 'asd'),
(4, 'asd'),
(5, 'vsdg'),
(6, 'h');

-- --------------------------------------------------------

--
-- Table structure for table `tbuildings`
--

CREATE TABLE `tbuildings` (
  `ID` int(11) NOT NULL,
  `BuildingCode` varchar(45) DEFAULT NULL,
  `BuildingDescription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbuildings`
--

INSERT INTO `tbuildings` (`ID`, `BuildingCode`, `BuildingDescription`) VALUES
(1, 'A', 'A BUILDING'),
(2, 'CAS', 'CAS BUILDING'),
(3, 'CHEDCHK', 'CHED AND CHK BUILDING'),
(4, 'D', 'D BUILDING'),
(5, 'DOST', 'DOST BUILDING'),
(6, 'TESDA', 'TESDA BUILDING'),
(7, 'DPWE', 'DPWE'),
(8, 'EDUC', 'EDUCATION BUILDING'),
(9, 'ENGINEERING1', 'ENGINEERING BUILDING 1'),
(10, 'ENGINEERING2', 'ENGINEERING BUILDING 2'),
(11, 'GARMENTS', 'GARMENTS BUILDING'),
(12, 'HIM', 'HIM BUILDING'),
(13, 'IT', 'IT BUILDING'),
(14, 'LAWMEDTECH', 'LAW AND MEDTECH BUILDING'),
(15, 'LIBRARY', 'LIBRARY BUILDING'),
(16, 'MED1', 'MEDICINE1'),
(17, 'MED2', 'MEDICINE2'),
(18, 'NEW', 'NEW BUILDING'),
(19, 'OLD BIOTECH', 'OLD BIOTECH BUILDING'),
(20, 'OLD1', 'OLD BUILDING1'),
(21, 'OLD2', 'OLD BUILDING2'),
(22, 'PA', 'PA BUILDING'),
(23, 'RECREATIONAL', 'RECREATIONAL BUILDING'),
(24, 'TECH1', 'TECHNOLOGY BUILDING1'),
(25, 'TECH2', 'TECHNOLOGY BUILDING2'),
(26, 'TECH3', 'TECHNOLOGY BUILDING3'),
(27, 'TECH4', 'TECHNOLOGY BUILDING4'),
(28, 'TECH5', 'TECHNOLOGY BUILDING5'),
(29, 'VETMED', 'VETMED BUILDING');

-- --------------------------------------------------------

--
-- Table structure for table `tchecklistprerequisite`
--

CREATE TABLE `tchecklistprerequisite` (
  `ID` int(11) NOT NULL,
  `ChecklistID` varchar(45) DEFAULT NULL,
  `SubjectID` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tchecklistprerequisite`
--

INSERT INTO `tchecklistprerequisite` (`ID`, `ChecklistID`, `SubjectID`) VALUES
(1, '9', '268'),
(2, '9', '269'),
(7, '103', '65'),
(8, '104', '67'),
(9, '105', '3'),
(10, '105', '3');

-- --------------------------------------------------------

--
-- Table structure for table `tchecklists`
--

CREATE TABLE `tchecklists` (
  `ID` int(11) NOT NULL,
  `CurriculumID` int(11) DEFAULT NULL,
  `SubjectID` int(11) DEFAULT NULL,
  `LabUnits` varchar(45) DEFAULT NULL,
  `LecUnits` varchar(45) DEFAULT NULL,
  `LabHours` varchar(45) DEFAULT NULL,
  `LecHours` varchar(45) DEFAULT NULL,
  `SubjectYearID` int(11) DEFAULT NULL,
  `SubjectTermID` int(11) DEFAULT NULL,
  `SubjectType` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tchecklists`
--

INSERT INTO `tchecklists` (`ID`, `CurriculumID`, `SubjectID`, `LabUnits`, `LecUnits`, `LabHours`, `LecHours`, `SubjectYearID`, `SubjectTermID`, `SubjectType`) VALUES
(1, 10, 268, '3', '2', '3', '2', 1, 1, NULL),
(2, 10, 269, '3', '2', '3', '2', 1, 1, NULL),
(3, 10, 270, '', '3', '', '3', 1, 1, NULL),
(4, 10, 271, '', '3', '', '3', 1, 1, NULL),
(5, 10, 272, '', '3', '', '3', 1, 1, NULL),
(6, 10, 273, '', '3', '', '3', 1, 1, NULL),
(7, 10, 274, '', '2', '', '2', 1, 1, NULL),
(8, 10, 275, '3', '3', '3', '3', 1, 1, NULL),
(9, 10, 276, '', '2', '', '2', 1, 2, NULL),
(10, 10, 277, '3', '2', '3', '2', 1, 2, NULL),
(11, 10, 278, '', '3', '', '3', 1, 2, NULL),
(12, 10, 279, '', '3', '', '3', 1, 2, NULL),
(13, 10, 280, '', '3', '', '3', 1, 2, NULL),
(14, 10, 281, NULL, '3', '', '3', 1, 2, NULL),
(15, 10, 282, NULL, '3', '', '3', 1, 2, NULL),
(42, 10, 283, '3', '2', '3', '2', 1, 2, NULL),
(43, 10, 293, '3', '3', '3', '3', 2, 1, NULL),
(44, 10, 294, '3', '2', '3', '2', 2, 1, NULL),
(45, 10, 295, NULL, '3', '', '3', 2, 1, NULL),
(46, 10, 296, '3', '2', '3', '2', 2, 1, NULL),
(47, 10, 297, NULL, '3', '', '3', 2, 1, NULL),
(48, 10, 298, '', '2', '', '2', 2, 1, NULL),
(49, 10, 299, NULL, '3', '', '3', 2, 1, NULL),
(50, 10, 300, NULL, '3', '', '3', 2, 1, NULL),
(51, 10, 301, NULL, '3', '', '3', 2, 1, NULL),
(52, 10, 302, '3', '2', '3', '2', 2, 2, NULL),
(53, 10, 303, '3', '2', '3', '2', 2, 2, NULL),
(54, 10, 304, '3', '2', '3', '2', 2, 2, NULL),
(55, 10, 305, '3', '2', '3', '2', 2, 2, NULL),
(56, 10, 306, ' ', '3', '', '3', 2, 2, NULL),
(57, 10, 307, '', '3', '', '3', 2, 2, NULL),
(58, 10, 308, '', '3', '', '3', 2, 2, NULL),
(59, 10, 309, NULL, '3', '', '3', 2, 2, NULL),
(60, 10, 310, NULL, '2', '', '2', 3, 1, NULL),
(61, 10, 311, '3', '3', '2', '2', 3, 1, NULL),
(62, 10, 312, '2', '2', '2', '2', 3, 1, NULL),
(63, 10, 313, NULL, '3', '', '3', 3, 1, NULL),
(64, 10, 314, NULL, '3', '', '3', 3, 1, NULL),
(65, 10, 315, NULL, '3', '', '3', 3, 1, NULL),
(66, 10, 316, NULL, '3', '', '3', 3, 1, NULL),
(67, 10, 317, NULL, '3', '', '3', 3, 2, NULL),
(68, 10, 318, '3', '2', '3', '2', 3, 2, NULL),
(69, 10, 319, NULL, '3', '', '3', 3, 2, NULL),
(70, 10, 320, NULL, '3', '', '3', 3, 2, NULL),
(71, 10, 321, '3', '2', '3', '2', 3, 2, NULL),
(72, 10, 322, NULL, '3', NULL, '3', 3, 2, NULL),
(73, 10, 323, NULL, '3', NULL, '3', 3, 2, NULL),
(86, 10, 324, NULL, '3', NULL, '3', 4, 1, NULL),
(87, 10, 325, '3', '2', '3', '2', 4, 1, NULL),
(88, 10, 326, NULL, '3', NULL, '3', 4, 1, NULL),
(89, 10, 327, '3', '2', '3', '2', 4, 1, NULL),
(90, 10, 328, '3', '2', '3', '2', 4, 1, NULL),
(91, 10, 329, '3', '3', '3', '3', 4, 2, NULL),
(98, 12, 22, '0', '1', '0', '1', 1, 1, 'Core'),
(99, 13, 22, '0', '0', '0', '0', 1, 1, 'Core'),
(100, 13, 284, '1', '3', '2', '4', 1, 1, 'Core'),
(101, 13, 31, '', '', '', '', 1, 1, 'Core'),
(102, 13, 241, '', '', '', '', 4, 2, 'Core'),
(103, 13, 65, '3', '', '3', '', 5, 6, 'Core'),
(104, 13, 67, '3', '', '3', '', 2, 2, 'Core'),
(105, 13, 3, '3', '', '3', '', 2, 2, 'Core'),
(106, 13, 22, '', '', '', '', 1, 1, 'Core');

-- --------------------------------------------------------

--
-- Table structure for table `tcities`
--

CREATE TABLE `tcities` (
  `ID` int(11) NOT NULL,
  `CityCode` varchar(45) DEFAULT NULL,
  `CityDescription` varchar(100) DEFAULT NULL,
  `Region` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tcities`
--

INSERT INTO `tcities` (`ID`, `CityCode`, `CityDescription`, `Region`) VALUES
(1, '01', 'PIAT', 'REGION 02'),
(2, '02', 'LASAM', 'REGION 02'),
(3, '03', 'LALLO', 'REGION 02'),
(4, '04', 'GONZAGA', 'REGION 02'),
(5, '00', 'TUGUEGARAO', 'REGION 02'),
(6, '05', 'APARRI', 'REGION 02'),
(7, '06', 'SANCHEZ MIRA', 'REGION 02'),
(8, '07', 'BUGUEY', 'REGION 02'),
(9, '08', 'CAUAYAN', 'REGION 02'),
(10, '09', 'SANTIAGO', 'REGION 02'),
(12, '10', 'SAMPLE', 'NCR'),
(13, 'sdf', 'sdf', 'Cordillera Administrative Region(CAR)');

-- --------------------------------------------------------

--
-- Table structure for table `tcolleges`
--

CREATE TABLE `tcolleges` (
  `ID` int(11) NOT NULL,
  `CollegeCode` varchar(45) DEFAULT NULL,
  `CollegeDescription` varchar(100) DEFAULT NULL,
  `CollegeHead` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tcolleges`
--

INSERT INTO `tcolleges` (`ID`, `CollegeCode`, `CollegeDescription`, `CollegeHead`) VALUES
(1, 'CICS', 'COLLEGE OF INFORMATION AND COMPUTING SCIENCES', 37),
(2, 'COE', 'COLLEGE OF ENGINEERING', 22),
(3, 'CHK', 'COLLEGE OF HUMAN KINETICS', 35),
(4, 'CPAd', 'COLLEGE OF PUBLIC ADMINISTRATION', 33),
(5, 'COM', 'COLLEGE OF MEDICINE', 34),
(6, 'CIT', 'COLLEGE OF INDUSTRIAL TECHNOLOGY', 31),
(7, 'CAS', 'COLLEGE OF ARTS AND SCIENCES', 35),
(8, 'CTE', 'COLLEGE OF TEACHER EDUCATION', NULL),
(9, 'CBEA', 'COLLEGE OF BUSINESS ENTREPRENEURSHIP AND ACCOUNTANCY', NULL),
(10, 'CHIM', 'COLLEGE OF HOSPITALITY INDUSTRY MANAGEMENT', NULL),
(11, 'CVETMED', 'COLLEGE OF VETERINARY MEDICINE', NULL),
(12, 'COL ', 'COLLEGE OFLAW', NULL),
(13, 'ALL', 'All Colleges', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tcontacts`
--

CREATE TABLE `tcontacts` (
  `ID` int(11) NOT NULL,
  `ContactName` varchar(50) NOT NULL,
  `Address` varchar(75) NOT NULL,
  `Contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tcontacts`
--

INSERT INTO `tcontacts` (`ID`, `ContactName`, `Address`, `Contact`) VALUES
(2, 'tests', 'tests', 'tests'),
(3, 'karl', 'balzain', 'test'),
(5, 'zxc', 'zxc', 'zxc');

-- --------------------------------------------------------

--
-- Table structure for table `tcourses`
--

CREATE TABLE `tcourses` (
  `ID` int(11) NOT NULL,
  `CourseCode` varchar(45) DEFAULT NULL,
  `CourseTitle` varchar(100) DEFAULT NULL,
  `CollegeID` int(11) DEFAULT NULL,
  `MajorID` int(11) DEFAULT NULL,
  `NoOfYears` int(11) DEFAULT NULL,
  `EducationLevel` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tcourses`
--

INSERT INTO `tcourses` (`ID`, `CourseCode`, `CourseTitle`, `CollegeID`, `MajorID`, `NoOfYears`, `EducationLevel`) VALUES
(66, 'BSE', 'BACHELOR IN SECONDARY EDUCATION', 8, 12, 4, 'COLLEGE'),
(67, 'BSIT', 'BACHELOR OF SCIENCE IN INFORMATION TECHNOLOGY', 1, 27, 4, 'COLLEGE'),
(68, 'BSIT', 'BACHELOR OF SCIENCE IN INFORMATION TECHNOLOGY', 1, 6, 4, 'COLLEGE'),
(69, 'BSIT', 'BACHELOR OF SCIENCE IN INDUSTRIAL TECHNOLOGY', 6, 22, 4, 'COLLEGE'),
(70, 'BSCS', 'BACHELOR OF SCIENCE IN COMPUTER SCIENCE', 1, 3, 4, 'COLLEGE'),
(71, 'BSE', 'BACHELOR OF SCIENCE IN ENGINEERING', 2, 2, 4, 'COLLEGE'),
(72, 'BSBA', 'BACHELOR OF SCIENCE IN BUSINESS ADMINSTRATION', 9, 7, 4, 'COLLEGE'),
(73, 'BAE', 'BACHELOR OF ARTS IN ECONOMICS', 7, 17, 4, 'COLLEGE'),
(74, 'BAE', 'BACHELOR OF SCIENCE IN ENGLISH', 7, 12, 4, 'COLLEGE'),
(75, 'BALM', 'BACHELOR OF SCIENCE IN LEGAL MAGANEMENT', 7, 1, 4, 'COLLEGE'),
(76, 'BSPA', 'BACHELOR OF SCIENCE IN PUBLIC ADMINISTRATION', 4, 17, 4, 'COLLEGE'),
(77, 'BL', 'BACHELOR OF LAWS', 12, 11, 4, 'COLLEGE'),
(78, 'BSBA', 'BACHELOR OF SCIENCE IN BUSINESS ADMINISTRATION', 9, 9, 4, 'COLLEGE'),
(79, 'BSA', 'BACHELOR OF SCIENCE IN ACCOUNTANCY', 9, 10, 4, 'COLLEGE'),
(80, 'BSE', 'BACHELOR OF SCIENCE IN ENTREPRENEURSHIP', 10, 23, 4, 'COLLEGE'),
(81, 'BSHIM', 'BACHELOR OF SCIENCE IN HOSPITALITY IDUSTRY MANAGEMENT', 10, 25, 4, 'COLLEGE'),
(82, 'BSPA', 'BACHELOR OF SCIENCE IN POLICE ADMINISTRATION', 7, 11, 4, 'COLLEGE'),
(83, 'BAMC', 'BACHELOR OF ARTS IN MASS COMMUNICATION', 7, 17, 4, 'COLLEGE'),
(84, 'BSEE', 'BACHELOR OF SCIENCE IN ELEMENTARY EDUCATION', 8, 13, 4, 'COLLEGE'),
(85, 'BSMT', 'BACHELOR OF SCIENCE IN MEDICAL TECHNOLOGY', 5, 11, 4, 'COLLEGE'),
(86, 'BSCE', 'BACHELOR OF SCIENCE IN CIVIL ENGINEERING', 2, 28, 5, 'COLLEGE');

-- --------------------------------------------------------

--
-- Table structure for table `tcurriculums`
--

CREATE TABLE `tcurriculums` (
  `ID` int(11) NOT NULL,
  `CurriculumCode` varchar(45) DEFAULT NULL,
  `CourseID` int(11) DEFAULT NULL,
  `EntryYear` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tcurriculums`
--

INSERT INTO `tcurriculums` (`ID`, `CurriculumCode`, `CourseID`, `EntryYear`) VALUES
(10, 'BSIT-WEBPROG2018', 67, 2018),
(11, 'BSIT-INFOTECH2013-2013', 68, 2013),
(12, 'BSCS-COMSCI2013-2013', 70, 2013),
(13, 'BSCE-DRAFT2013-2013', 86, 2013);

-- --------------------------------------------------------

--
-- Table structure for table `tdepartments`
--

CREATE TABLE `tdepartments` (
  `ID` int(11) NOT NULL,
  `DepartmentCode` varchar(45) DEFAULT NULL,
  `DepartmentDescription` varchar(100) DEFAULT NULL,
  `DepartmentHead` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tdepartments`
--

INSERT INTO `tdepartments` (`ID`, `DepartmentCode`, `DepartmentDescription`, `DepartmentHead`) VALUES
(1, 'REG', 'REGISTRAR', 31),
(3, 'LAN', 'LOCAL AREA NETWORK', NULL),
(25, 'OSSW', 'Office of the Student Social Welfare', 0);

-- --------------------------------------------------------

--
-- Table structure for table `temployees`
--

CREATE TABLE `temployees` (
  `ID` int(11) NOT NULL,
  `EmployeeID` varchar(45) DEFAULT NULL,
  `Salutation` varchar(45) DEFAULT NULL,
  `LastName` varchar(45) DEFAULT NULL,
  `FirstName` varchar(45) DEFAULT NULL,
  `MiddleName` varchar(45) DEFAULT NULL,
  `PositionID` int(11) DEFAULT NULL,
  `DepartmentID` int(11) DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `FacultyRankID` int(11) DEFAULT NULL,
  `SalaryGradeID` int(11) DEFAULT NULL,
  `CollegeID` int(11) DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL,
  `Address` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `temployees`
--

INSERT INTO `temployees` (`ID`, `EmployeeID`, `Salutation`, `LastName`, `FirstName`, `MiddleName`, `PositionID`, `DepartmentID`, `Gender`, `FacultyRankID`, `SalaryGradeID`, `CollegeID`, `Status`, `Address`) VALUES
(42, '11-13826', 'Mr.', 'Cabasag', 'Vince Gilbert', 'Magramo', 29, 3, 'MALE', 0, 5, 12, 'Contractual', 'Tuguegarao City');

-- --------------------------------------------------------

--
-- Table structure for table `tfacultyranks`
--

CREATE TABLE `tfacultyranks` (
  `ID` int(11) NOT NULL,
  `RankCode` varchar(45) DEFAULT NULL,
  `RankDescription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tfacultyranks`
--

INSERT INTO `tfacultyranks` (`ID`, `RankCode`, `RankDescription`) VALUES
(1, 'ASSOC 1', 'Associate 1'),
(5, 'JTA', 'Junior Teaching Assistant'),
(6, 'TA', 'Teaching Assistant'),
(7, 'STA', 'Senior Teaching Assistant'),
(8, 'ASST. PROF.', 'Assistant Professor'),
(9, 'ACCOC. PROF.', 'Associate Professor');

-- --------------------------------------------------------

--
-- Table structure for table `tfees`
--

CREATE TABLE `tfees` (
  `ID` int(11) NOT NULL,
  `FeeCode` varchar(45) DEFAULT NULL,
  `FeeDescription` varchar(100) DEFAULT NULL,
  `FeeCategory` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tfees`
--

INSERT INTO `tfees` (`ID`, `FeeCode`, `FeeDescription`, `FeeCategory`) VALUES
(1, '1', 'AIRCON', 'MISCELLANEOUS '),
(2, '10', 'SCUAA', 'MISCELLANEOUS '),
(3, '11', 'SOCIAL CUTURE', 'MISCELLANEOUS '),
(4, '12', 'STUDENT PUBLICATION', 'MISCELLANEOUS '),
(5, '13', 'TEST PAPER/ TEST BOOKLET', 'MISCELLANEOUS '),
(6, '14', 'USG', 'MISCELLANEOUS '),
(7, '15', 'AFFILIATION', 'OTHER'),
(8, '16', 'CMS HANDBOOK', 'OTHER'),
(9, '17', 'DORMITORY', 'OTHER'),
(10, '18', 'ET CETERA', 'OTHER'),
(11, '19', 'ID WITH STRAP', 'OTHER'),
(12, '20', 'ATHLETIC', 'MISCELLANEOUS '),
(13, '21', 'NSTP', 'OTHER'),
(14, '22', 'NSTP UNIFORM', 'OTHER'),
(15, '23', 'STUDENT MANUAL', 'OTHER'),
(16, '24', 'TUITION', 'TUITION'),
(17, '25', 'ADDING/CANCELLING(PER TRANSACTION)', 'OTHER'),
(18, '26', 'TRANSCRIPT OF RECORDS (PER PAGE)', 'OTHER'),
(19, '29', 'REPLACEMENT OF EXAM PERMIT', 'OTHER'),
(20, '3', 'CSG', 'MISCELLANEOUS '),
(21, '30', 'CERTIFICATION (PER COPY)', 'OTHER'),
(22, '31', 'SPECIAL EXAM (PER SUBJECT)', 'OTHER'),
(23, '33', 'STUDENT TEACHING MANUAL', 'OTHER'),
(24, '34', 'COMPREHENSIVE EXAMINATION', 'Others'),
(25, '35', 'MTS', 'MISCELLANEOUS '),
(26, '36', 'REPLACEMENT OF LIBRARY CARD', 'OTHER'),
(27, '37', 'PROCESSING', 'OTHER'),
(28, '38', 'MISCELLANEOUS ', 'MISCELLANEOUS '),
(29, '39', 'INSURANCE', 'MISCELLANEOUS '),
(30, '4', 'GUIDANCE AND COUNSELLING', 'MISCELLANEOUS '),
(31, '40', 'CLASS CARD', 'MISCELLANEOUS '),
(32, '41', 'CLERKSHIP', 'OTHER'),
(33, '42', 'CLUSTER MEET', 'OTHER'),
(34, '43', 'INSTITUTIONAL SHARE', 'OTHER'),
(35, '44', 'CLEARANCE AND CERTIFICATION', 'OTHER'),
(36, '45', 'GUIDANCE TESTING', 'OTHER'),
(37, '46', 'CAT/ENTRANCE EXAMINATION', 'OTHER'),
(38, '47', 'LAW HANDBOOK', 'MISCELLANEOUS '),
(39, '48', 'CENTER FOR LEGAL AID', 'MISCELLANEOUS '),
(40, '49', 'REVALIDA', 'OTHER'),
(41, '5', 'LIBRARY', 'MISCELLANEOUS '),
(42, '50', 'DIPLOMA', 'OTHER'),
(43, '51', 'GRADUATION', 'OTHER'),
(44, '53', 'SEMINAR', 'OTHER'),
(45, '54', 'LABORATORY', 'OTHER'),
(46, '55', 'COMPUTER LABORATORY', 'Laboratory'),
(47, '56', 'INTERNET', 'OTHER'),
(48, '57', 'MUSEUM', 'OTHER'),
(49, '58', 'THESIS/RESEARCH', 'OTHER'),
(50, '6', 'LSG, BAR-OPS, CENTER FOR LEGAL-AIDS, MOOT COURT', 'MISCELLANEOUS '),
(51, '60', 'INTERNSHIP/OJT', 'OTHER'),
(52, '61', 'HARROWING AND PLOWING', 'OTHER'),
(53, '62', 'MEDTECH/VETMED LABORATORY', 'OTHER'),
(54, '63', 'FINES AND PENALTIES', 'OTHER'),
(55, '64', 'RENTAL', 'OTHER'),
(56, '65', 'SCRAP MMATERIALS', 'OTHER'),
(57, '66', 'BOOKS', 'OTHER'),
(58, '67', 'UNIFORM', 'OTHER'),
(59, '68', 'BIDDING DOCUMENTS', 'OTHER'),
(60, '69', 'OTHER BUSINESS INCOME', 'Others'),
(61, '7', 'MEDICAL/DENTAL', 'MISCELLANEOUS '),
(62, '70', 'DENTAL TREATMENT', 'OTHER'),
(63, '71', 'ROTC', 'MISCELLANEOUS '),
(64, '72', 'BID SECURITY', 'MISCELLANEOUS '),
(65, '73', 'PERFORRMANCE BOND', 'MISCELLANEOUS '),
(66, '76', 'GSCC MEMBERSHIP AND ACTIVTIES', 'MISCELLANEOUS '),
(67, '77', 'MEDTECH SOCIETY FEE', 'OTHER'),
(68, '78', 'RED CROSS', 'MISCELLANEOUS '),
(69, '79', 'DEATH AIDE', 'MISCELLANEOUS '),
(70, '8', 'POSTAGE/MAILING', 'MISCELLANEOUS '),
(71, '80', 'LET REVIEW', 'MISCELLANEOUS '),
(72, '81', 'PANADAMMAN', 'MISCELLANEOUS '),
(73, '82', 'STUDENT BODY ORGANIZATION (SB0)', 'MISCELLANEOUS '),
(74, '83', 'SERVICE', 'MISCELLANEOUS '),
(75, '84', 'ALUMNI', 'Laboratory'),
(76, 'asdas', 'asdasd', 'Laboratory');

-- --------------------------------------------------------

--
-- Table structure for table `timages`
--

CREATE TABLE `timages` (
  `ID` int(11) NOT NULL,
  `EmployeeID` varchar(45) DEFAULT NULL,
  `ProfilePicture` mediumblob
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `timages`
--

INSERT INTO `timages` (`ID`, `EmployeeID`, `ProfilePicture`) VALUES
(9, '11-13826', 0xffd8ffe000104a46494600010201000000000000ffe2021c4943435f50524f46494c450001010000020c6c636d73021000006d6e74725247422058595a2007dc00010019000300290039616373704150504c0000000000000000000000000000000000000000000000000000f6d6000100000000d32d6c636d7300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a64657363000000fc0000005e637072740000015c0000000b777470740000016800000014626b70740000017c000000147258595a00000190000000146758595a000001a4000000146258595a000001b80000001472545243000001cc0000004067545243000001cc0000004062545243000001cc0000004064657363000000000000000363320000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000074657874000000004642000058595a20000000000000f6d6000100000000d32d58595a20000000000000031600000333000002a458595a200000000000006fa2000038f50000039058595a2000000000000062990000b785000018da58595a2000000000000024a000000f840000b6cf63757276000000000000001a000000cb01c903630592086b0bf6103f15511b3421f1299032183b92460551775ded6b707a0589b19a7cac69bf7dd3c3e930ffffffdb004300090607080706090808080a0a090b0e170f0e0d0d0e1c14151117221e2323211e2020252a352d2527322820202e3f2f3237393c3c3c242d4246413a46353b3c39ffdb0043010a0a0a0e0c0e1b0f0f1b392620263939393939393939393939393939393939393939393939393939393939393939393939393939393939393939393939393939ffc20011080140014003002200011101021101ffc4001b00010002030101000000000000000000000001020304050607ffc4001801010101010100000000000000000000000001030204ffda000c03000001100210000001f7000000000001a66e3cdf3cf68f9d6e2fb9723a89752e00000000000000000000034b4bc19dcf3da56bd64c73244ac474b8f07b0eb7ceb3a7d863cf7464e93576490000000000000000393d5f0070752f8ef57adaa5ad5cc522e5c2d9ac6189a267eef981eebd17cdfd6d9eb18f248000000000000001c2f9bfb0f197a95b2982f976b9eb16ee7ebe7af3367a169d686af62b1e5f47d9ea59e331fa3e1779e2f63e37b3de5f50cdafb08000000000000001f3af35eb7ca5eb3f579be933d79d9f6dc69b5b1ab9a5ccc73178ad4b6142eb71bbda36793bdb0ede6fadf4f8bdabc000000000000000786f23ed7c43aeb76b43671f44e68d92fb7cfa59d688d8975f167e697c349aa518f9be774fafc9d71fa7f7b91d7eb2000000000000000f31e03e91f3d75dfddd7dcc3d39aba9af5d3cdc8ddb377369df9b9f1d34eb75c18bcf779b6dae7af3dc1f4be7b4cfeb5bd833f78000000000000000697ce3dbf078defb15dbcf55ed0571e4d7315e9b4b833e1c89951735f1eee0391caedec779fb0b44e9e7000000000000000f3fcfeaf3b1f55367576e5cf313663d4d9d49d4f474725444419f2532c95c1b3ac686c61ccbea726a6dede40b00000000000000e272bbfc5cbd3afbda1bdcf79eb309871e35b96d9ab55aceac6de6d7cf25f5f635ce7dab95d7a8d9c5976f1858000000000000063d1e925f259763472f46ece1b4eb1e8f531dbabb1117ab68ee9ceb74693265d5cda71b3bdbdb3a611277980000000000000001c4e3f638b97a36ad82fcf7b3935b608ae552b6a94a4e289c32b3d74c4ebe50a0000000000000001438bc9dcd4cbd317473d5f2639acb38119e98c210575f634abd5757c8fabdbcb70800000000000000c664d4ae0b74b47bde733df3c6567a6064189b1635a7342639cb635f93d8e4f53d0f56b4dbcdd168ec4998000000000063d73731e9e2acfae8b63262ca6c79defeb73d7372f3ba587a6b19212b69b18ed6b15a5f50d2dee4fa5d33e862f3fd2d71dbadb199f6b9f29d59e6edf2ce000031eb9b1830d2af158b6b3190ad6f52299f9057775bab6e869f5b4f2d2ed5dacb5b01118cc7cfcd92b737f2ea6fe6e6e6decbd35f6a964ae1cd8a2d6c574cdb3a3075a799b71b0239f155b095522d42d931e426b30639c9731daf4aa2f58e464e9f272df6548cfb6b5b587a0c36db0a5f265ef8890420ad6f52a9242c2abd572ef72ed24c5d6e39981092b741745889904494b285ab9657cfdb6f9587a326de877bae73d22fae162098981011130051026202b62644259ada4c7371599931cde0104a05ab22b92924f94f4159d536a97b232d6e82444c10982b5b510a8b440b2249989abcab2da204a05e6b61313089555682a91116a1ad836f11b74b4933221350002b1682ab12b16145eb4b449fffc4002c100002020103030304010501000000000001020003110410120521401320301422313206233334415042ffda0008010000010502ff00af6ea69a659d5e8587ad187aadf2aeb4f34dd428be6440c0f9f7eaa9a26abac125f516584be76e3b76946baea82f531c6bd7ab4133dfcad6750a74f353acf58edda6609c843de0cccc4b194749d58b6ad5bf034dcb6793add4fa55da7d461eec19833bef55ad4d9a9ea3eb8d26a88d3e8ecf517c63d8754d5a58ec7726080667e2729910f133f13399f8db4d684afa75bc6b43c97c5eaf670d2fb1562d7134e0c5d1a41a4aa7d35787d1a18fa3223d0c2118d84d2588a2b6e43c5ebcdf77e6622ae61588b8952722a9898df1088cb2ea034b10a19d3179ea2b60c3c5fe41cbea96095d7f68abef099358026667dad1966ad7b4ac90fa3e7e978bfc887f5565632cbd863600cc7b73330cb5721c60ff00be9367a9a4f17f912fdcb346b9685a2308b624521a709c215870212a634cc6970fba74618d278bfc887d8269062b6262513d0587489069ca1ad8ecf1eb2f3e94cfa7710a308ad99ac5c34e9608d178bd7c674a2563095a6dea8105c86039dced99c843de5b5e0eac66b9a2ff0017c5eb233a2ac659603d9d5de7d1120691c37060ccddc34e5ddcb1626f0c2cd428aaee51bf5d40fe9a8cb52bc6af1756aafa745c5cb00806e7b7b077dca432e194d069cdfa91e3750732daf0e8228f639ec333846ed177c4612d1dba46296f1b57fe45c3ed4820d9ff000b8cfad5f3e427ab51b18622eed2c98e2b59ca78badfdee6e489041b3187f2b310aae7f314ec618dfbde309a5fecf8baff00d9d0e2b8376989db7c458218d18e1f96534ffd9f1758b9420e13f220db516fa7128b5c7d219f4d664e9ed13d4291483b18d3ff0067ee958c278aebc97e9e5c9e9dc20dac4e40b58207b4c16da21beec3daed34d5f051b3cd3d0cea34e73e4750187533333b6271130271cce03606131ccd3af0abc9ea3176133b6271d8ee627dd6f95d476076060f693b31947f7fcaea073ede539ce739c2fb98cdc668f51eaa790c70357fb7b7026263d866a3b55d24e685391e3dad35abfd31b637ef3bcef3131b626b0fd9d3abf4f4a8d83e2970235a67e63af34ab6c4c6f8db131311fb044fa8d428c03058441603e116023584ee209ae5f4af5391b62637c6c66a1e74dab090eeae44160f94b010d8664ccee2099e22ce1a95af35b898f719634e26c761c69f52d46ab54b6c23d81888b603f09610b133b4cc273b983265d6ad2031b652be9b6ae8e72ab3deed18e668a9c071996af26f4f88a3b0ec615f62b9116c99f6160217cc27de0663b70574e52aaf059792a3107534446f6b18c65157a8f2db312aaf802b9804c4c423da1a2d9f10db31866049c7674e52b6ccb93d3b10ee6398aa5dab415a58f2baf8fcab662039f78f79d9d6605a841adb30984c3de69eaf4d6c258a205f9d588f807c026306d4162e4a9266669d724f6807fc2135b5e543642296645e30c1e09f0bf31d7d2be94f493f5583de7e1ff67e1c4c7bc4b1b833a217af2d0c1f01f847876af30fdcfe07c9898f1cc1295ef078467fffc4002111000104010501010100000000000000000100021130200310213140122232ffda0008010211013f01a63cd1e38bc6c020c5f2a02f909cdb426040624222c09a20295ca952a54a7776350d828da767d8c671343c58cfe693dd7a678c3e9b89eeb06134c8dff2bf3b9d436e9f591eae675914eb74ce4ee91b5a632d437b1d81e11327c0c74eee74f87a4d329e7c6d30899f77ffc40020110001050100030003000000000000000001000211203010213140124160ffda0008010111013f01fe0e5172952bf240a1ab8a26a10d4f93cf0a1428509bafef87b1c6685d83343ef119ba90a3784eeca9e81abac367586cf166e71d226cc148ac59eda00808ac28c9cdeb5b1f0fb4e10983e3225011f77fffc4002f1000010301060504020105000000000000010002112110122030314003224151613250718113a1722333425291ffda0008010000063f02f77e7780b92f397f6a3eece7603fa5add7762b5f60fea3c051c2803ba9757e70f6517af0f3d15f3cbc5fd39338a3d2ea1f1bd8265dd9186c61aae9808068ed50613ccd4cf9463a6e4dd6de28bdf03e3150620f6ea17088d46a13ddd4944f4d3717195032aaa8ab699d7a2a9a42076c79a272745a2a531327d47f4a7a6d9a24c608caa283609341dd536c24d2296f92be3344205db6e11f160b69946d6f8db708d9383d4150e1d701b06bf7b6e11f364a81656c96955b755aad70f0e4cd36cdfe5600a6ce83e551cdc9bc14f6b385fc76c7e50b68e844174ca92f90a5b030686ead1d13fa5cc2f7d28208f9b0a0130761b67b5dd946794d6f49aedc342073cae6d5da6dc12a4f7c555744ff00cb2e970954c4d70e881db34af8c99ba2710461376cc44cec5bb607b2a61d24a0e2755eb51217450f0a9840080db4289a2230c5e2bd6b508a8741a42eb82f85a46e5aeef9cd1ba666b479ddb3359f3bb68cdbc3a213ba6e6b94ee6107ff00a9cd84c9edb8a585bdd5c3ab6998074d4ef071068ed72e117c7ab694552a9865c61167ed1e1bba6540eaaea90e2b99b77caa5467f6c8eef5cc6aa0afc8df5055c9be6cb8d516d3694536dd3aafc8cfbc8f0a3a2badd55753975d8f9507554d0e280a15d6eaa4fab7d786aa0a8387cabadd853632179506d9f65fc8351ad9015d1a0f66770fa74527d67d9be5378aeff157ddf5ecd09acf67945db5ffc400281000020103030403010100030000000000000111102131415161204071813091a1b1c150d1e1ffda0008010000013f21ff0097597eda458e0c5c0ee2f6a253869edba15fedc85a92f5b139c246f692e09a27be412c36d460f301285f90c0c781df1224596c70b465974db08112b0b3f066545e62e9e7924a68fb864d4ac0d141f76a5f1231d1893d1096f1e88bff00d9672c9ad9175ffa199de141ee5ed0d7eb13f8fc9a55ebea360b89087d8139c770e55f0ef090f940f443821bd086f53f1092f1fd3d9e49effe524b710c71ec6cf0c9f25e9261390d5fae0da159dbba636e122f3b509e463b244688848b9084fba071aa4f064f75663600e724a1c502e27525a4a4c39316a4485bb2c8c4f6cc5169cc5f4e7266ff00847d7f487ae4f60e66466063322da9b1da46886085b3032c631a18eb65fc441a2e1cf6d794058d09c9fa1410d748b901293b0fc02d44228d8b271974b1d724a92ae5c283795bf6dbb958191fa1ea41712ac8252a2c27d0810256c4ad891f91294aae3035039f29276a9a8b5a3b676444d1f5a59601a43b095eca64fb52491bd465ce8891322b484b8a66c73db6b1c34604ab6112721ab36618b5fba2ed28aa2f06801235248694c8bc9494cb4eeed9fe791997f6ac7374b32ddc4ec98ee2c498af0448cc9433d0d7d049880d1b2b5e456ff8626ab25c3732c9f6d09eda5318fa585b9c1684642703cb68e43186bd8bd42cd6dc11dcd0911642b09b9181aa35edbb3b67c7d10846ec5108aa8718316d4c789224a38425905aadd09c066e34c98dea24d56a2a29e5969c0456c6d5319e5d85ec5b783919a14a74576cf42131ab2cc5b129190885bb1e161664525c5f06431a9d053bc22c507a89cc318484976d79e05eabd0112342172159e04da88df06129888abb0702b915a8dbb748c221f00634a1067815a424b83596143a0d923da4f9092a481aa16e4356619c94bb648249721e861bb51d4ba6337920388d03581dd9f4222050cc29c1e44b8d67a0d3db4aded5c80ecdaaa1ba79c2134d4f0cf630c34175372d894cf51613c76dcf01c64962d852c45c4452666052352c1063f02949689a72d037252f28bcb4a164c297aa260c62149c14bb64b9f526d4a3aa087f1a0e3515c843c449e85e7f64b5e92310ae84495a447e8d5a96f3431ac58044c431956d3d8565dc71a20b4208650f7a3868713129d9185d01785fba7b2f91a09b0e208722133a8954dde06139f0bbaff7314a6935228ddae209ef0e62d9594d99159d13815630825b26866f2e2459f7322c77e691102b0996742040b2c0dd5f40396dbc112fb891c742c0dcf42103a21e951090845175bc72490dc8b53c76d9a77e0e0052d2c4b6c240ed4e5a42a1842446970a93290768bfa0b0d169b34714f9ec97dd9c421b35a8d53d2f210a68486a84204b814885a516604817359f06296c93551ccd84d3c7c99d7f46990372970e6e8c516791ac0939166fcf063db16d05d4410682a310a64166682392d0a11f554c5173f01f9f40b4d2618f6cccc59fc2962ef8330e036bb8f6a430251471590910a57bf06790324225599f6d96e4d6c84e4441146e08073098bbbc52b539b5638aaac8945361eb281eb7226e264980621e448f0e7a3cc0e0d3cd18a9031ecacb52c198c694b63a71113fb348bfd2f47e04ea886c9a339129e17662cb2611b81c5c97666284343a14a05496862733f429ff00aae7a1ba2a19276c2da8164131106563867006518e3cdc122a36351d65ff000524f6c6cc12ff0086fc6cbe96fa608a3bc452ca249a31a31421d10a882649b6fd1c61ff0087d2a62aca4f0b2224777c9f659886d9d5bea748208208190589a91d1062a810a8c76638f6610bd18648e745818c6f16458f827f0c4b51481ae883027d4d186272a8b23fd48c589391b150c0ddeec697f01f4c935593210c8208a41149e9685664ea3691a78d50dd717e68f493c0b06af3f1124924f4aca854820820823e020b062761e3cfc97bad86c6627ce42358eb24924fc96a387a08d4b94ac44084a5897c0c822a4742b2e8823e658decb97afa1dc4f85f541157ffda000c03000001110211000010f3cf3cf3cf308c2530f3cf3cf3cf3cf3cf3cf38ffc8fa1b96fcf3cf3cf3cf3cf3cf07f998680874ccf3cf3cf3cf3cf3ce0027f0d8a50783fbcf3cf3cf3cf3cf28caa3576ea31d0fcf3cf3cf3cf3cb2e28f0ce4b0ece2bcf3cf3cf3cf3ca05070c7292d6922bcf3cf3cf3cf3ca3010805ca7a520f3cf3cf3cf3cf3ce3f5f95e422b1a90fcf3cf3cf3cf3ca2681e6152ebeea3bcf3cf3cf3cf3cf1b97172edfd18233cf3cf3cf3cf3cf3c0f12f8725c6af3cf3cf3cf3cf3cf2c6b780ee97569f3cf3cf3cf3cf3ce0cb04db83c37437f4f3cf3cf3cd9991d2ee74988b4d7589db4f3cfa381815762e682ebc0e810e0f5674cb4c286b7a4ff2baf3ce2fa27ff197ab0734232a9f40826b9926a2038b153b8a28916396eb8d86fb6983ed74e99b2510a908badba3b2dbe0ae2cb940ffc4001f1101010100020203010100000000000000010011103021312040415161ffda0008010211013f10e8c6d59f403600f8933b48e41b5649276b3657c447bb1c4b4849dada11de339d8b267b50ab60ad5b8d463d6361e326d7e9c3234e6591c67b01f05eec9b2c8664d3b1784f07a9083262f664711d7e8cf021ed8fe968fa662dc25a9eb5f49bc96421eed5ec93f04ff97af3684ef5b782f7771af19671e9037c7605e2c9e7785916b674e59c3a844d3e05e0cb3a33e3b7e2fc1636f216cfc3383a3063c7ab761f4455a46630cfa8d96bf7bfffc4001f1100030002030101010100000000000000000111103021314120405161ffda0008010111013f10d109f852fa6b6af8a543653bd9e146890df0b284c85b187afc2431a2fc3c638f5be87049220684123fe0e487adf43614f445386510ff00d0dc1b81ebe687a3e0a247451f2325dfe0931f2418b81aad691dca5716cb0f0b85ada3123289c1065ba4a2d2dbd898b9ee2dbdf3c67b138d8912e459584ac4869e84ae096248351cf9b126251fc12a2f84c7a2f8b324f9e43c16893ab129257a1aa79a1a82a2bc8b4f9aba126af34a5aff00ffc4002a100100020202020104020203010100000001001121314151617110408191b120a1c1d130e1f0f150ffda0008010000013f10ff00f59c11820b9e5f897801c62c3a868c293b91b435f831f987d06194c8fd32c42995fe8e98b084b40587ab034f87af700e93eb99f046ea55985ab2dfea5efaead4f753615f725f1b2bcc332bc54654a9071299331499d5c17b3c9eb53730f1f4c0d539a232a0dbbde5fb2f30530a2c7c43cd94b0faa7506757c2af71f83b000bfbee1b9a97a5b03a01e55b05b37e2311d6f4b19645aee92a6bdaee29abea51a09461ab94845100dc58dd1c58258d0442c8efd7f988f620acdb5586081b07e9dd4cdc6f8af2c79720563f3b7ef16781ce62d529970bc2b52c30a7f64f4fdd5aff00514aa1f2ff00588ad54f584aaeafec906e18f4973c08f822d1c0e523c32a978f095e95206078af1b8cfb5c305bf6ca39a607ba32fe7e9c4b02d568094a13cd8bfae0fdca107b5c1ea0b629ca9b85135fe22b46d3c413df79ba882af5dc7833788312dc9430039b26e53c90a2d8e8605152731b30d92e60d5cbf3b7a76b07eee222645d9dcb5d2fea3b8a9baafa631cd1b6539986e41d72416cc15681c416d6c63dba9776e9c1e09668b4a5b03dc133f110c18085f212cad7978872e4f72e6d32053b9871082bd4f411f1c842b5c143199384775c7d2ba958c252993e3ccb9d05e11d145b824335f8265f655cb40c68770f2a073a868ab94980f50a71511718fb415e58ae83ee10b62a06859e2220aea69988ad4e094f0f05284f1f4ac0191eaa3b8716adfd4c2af2982363ccab1199ee132832fb848b15d4a9d8c39c967fda78044718f529d182901b9bf6aa61a6f1141aa6981b30d074fb43cd7d291d97c0dcf085355e61dcc2622810376c3fd88ced84a544fcdcb86373ce7992973004023d4360e2382b98920a236247e164d6dfa5753c9db98dcc16a512b1c4405ba816d87c41d0e9a940badb160455f6423ab9929c89e1d4b0a0441a57dcdb07e63e612edd9330330e181668db929f1e3e99021a14fd8996952ff038a226258594075b7dbee1a8b3909a3dbb1988adb2d894f9f9bdc68b9417a4c323b1100210cb7b940e242b13006b4a05d08d83c41afa3640a4cef8814e3654c1d59bfa5621974f378c938bde2a52fc37edccb0117dc1cd6613be511221380c12a892a0b837a6547ccb5c4f1bd11a32df550ba021010f680e4957d9858c28dec972e06c529d7d2ba8b24572f44eb6025dff00b821ab7d129f1768c0914a46d3d4b495f4da083f7202a26ad6bd1c4c06152910cc860c3c927d3a2662343db815ddd665c6ebb40becfb4d33f8350846a58ae2d01414360b9615415f83e95d304438dad526a25b05956535290f71a8b2a167de3e2fb448fe884997b8cb21558b8472bcc216b00b082471a45b620554a0bb504050d050d04023415f4aea1165298396e7ade71ccb080712acc11cd14b699b15ad10e0a952c331d49d456723a8d4ce217ee212a066320bca21ae460f0ebe998422c2c3c863fb89a216d55dc5426d8d4b0d4a1c41e6457c18802696c57e7529148b620c5f308dc45e250adb00414ff30d597300ed97d83fb8824e687e95d427f4661522905fccb43c11cc5529d2e0d64c7138360e25c97a81959fcc6cac06cfccb02e0708c36a8f05ca0bdccdb9458591d82ae9194f4fefe95d4a0785bf24158919e9138eaa70810c6a36a64cd2d079980cdf1379c30c9ca1199dd2e788293017b820ef05fea22d88f37dc1f1d7e95d4c7bdaf87119234fc4ba2c2623ac4d846d043c74262db96721ea2e6dc179da6c220b6cdc00d7c05b83acbcd5f884545d301a4e99a44db0f844d1d322a71bd67f5f4da918690d9a729325828dba9756604dccb428e1e6e59b6308e62ed0be55127719e751c00c0a375e60f16c85d584c665e77533cf24789528f09a5ca7cc3c708d968683afa7704a98c5a7c90a9995f997b5751acd0d36111bc4fb4fcfc03018507b98d6272ca28c4a0087515b0dba989292efb7ea88672fe84bd4e881cae0ece65c871059a87c481580f094158208b729e82563984c3813fb802abea863dff4225ae61215778f8850ccdc6c1994079846486d46edcb89a1cd61c7d4e8ce709bf103485f1c3313285a54614e657bcc0adca98cb2c5b1a1b8b983dd588c7d4342f987d41f3411c4e82fbc291b7115a0cbdd52e71fbf8d8d60da65c4a58788ec5d672ef2c56ee76c69f7f4cfc50a765ed8e11a91e587f709046ca97ea552b862a451e165e950459b946f52eea35dca43bde679883de4fdc076cdfc30cfd2a356f4ca296803bcb16c8b99b1b6bef06c460775cfea0bbee213329f302404c93c044d812f1db286ff0011426a5e0b5b7c20092a8af5e3f506655a07a8dd2f8a0a7ffbf438d77d0e598017acdfde5f831de60de6c76f88311cc5780c1ffccd493f064c9528ca1dc71cfee018329632d4a88a82b2e48b78c44a0b30ebff00729063ef3932cf732634061d2626b6beeec84da13bff00931d63d429681dbb9f6a11301f9313eeb128d71328ca1fa46e4e5aaac4b82aa056ba19799ff99f7941666e38556a5c7c439caf6963750d5ca0be662cc47ced3aed8d772003d7fb6150a1c8a3f686452ea8e4c3171b2d410adabe1996082acf52d099e998367f532ff9dcc6dbaa0ca3e837338650385e6315772b6273307b9a5236ca760307f945773673a0f5c4b9efba8ea60581e0e3fee57aa8e11e3c40d20264414aa83151088aee20c7b7d84a769c6a1336f25a082e544158adc2ce3cbb805d3c52dda177046a61543d6269e1e484d80f1fc30ab7d23c86ba200a10f507376587c0e6562349cbcb68295af9ea39b0b95dcb0ce6609760d8c75e157877287e97fb9559fcc1e6294c66819777514837db1a0085a0ea320dc70ea20e49e69c04eae2368bc29ea28dedf3123495d411ccaf10f94c6acffe6b88360888fc2a96e2018899892862dcf09a4ccee24c0e94a0128164300662e200e1cfd910a1581f981716d17a78250e61b954db281cc1a0ab7d794af2b0bec9fe984420a734dcdc0988bd46896c481f194c60a468157ac12d63147a979b9a4b223e9f23c4a83e2ea5135c46056e3a4684c99ed45b7d1f70ee125dc1ce6564ad0b4d04ac002d76f50025067afc4c656bc863d4ac7c3f1a44f8197f0023ca2b6c1d912ee316906332956c45f98969181f21706894e1e62a6c6c96a6337530b343524b70730d697701b52b22292b182556f2e5f7347cb1f8d3f8dc58b1c45db547728fc0e25c199408fc92ac8188952e5cb8843113071a8b7a4b020372be73326f58ff007f1c1463389c25e25fc3fcb72fe4b9c9349c87c8171864ac0f830290c62dcb972f12e8d938060f174aec39264b2d8b938ff106a446874ebdc283ce6f680acc03e0dc48fcea7f12b82dcb84cfc189b7c2ae10c1fc028c62aa537fc1b45a3a88de2948cd1a70d966c5b6ce115a79f8cc4e6045e3e1f8388912532981fc03b7982d8152ea3f19240fcd4a891257cad455e22ba6232a2f3cf2c08ba0fd7c0504a951f9e7e0c70f99c353acaa81343ea0a4f1172c5f32e65f008150d437fc18ca95f0e86314e10ee64c9ecc59752b9af8751ff80b2d97710c62b13003ed3fffd9),
(10, '123', 0xffd8ffe000104a46494600010101000000000000ffdb0043000906071212121012101010101010100f1010100f0f100f0f0f101511161615121515181d2820181a251b151521312125292b2e2e2e171f3338332d37282d2e2bffdb0043010a0a0a0e0d0e1a10101a2d1d1f252b2d2d2d2d2f2d2d2d2d2d2d2d2d2d2d2e2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2b2d2b2b2d2b2d2d2d2b2d2d2d2dffc000110800e100e103012200021101031101ffc4001b00000105010100000000000000000000000001020304050607ffc4003c10000104000404040404030705010000000100020311041221310541516106132271324281911452b1c123a1d1073362637282a215435392e116ffc4001a010002030101000000000000000000000000010203040506ffc4002911000202010402020200070000000000000001021103041221314151052213320614237181a1f0ffda000c03010002110311003f00ef814210bb470c54d4a1220608485220052910913014948912840024294a428012d08082503152268068bcd000d6e342a31382744876894a133cc09414058a424a45a020625213934a090852a4290a0072694a10521a1134a726a061484a84017535c9c534a667118e4e4d010800284850980244a9103008b414d400ea45a8e6943412e34173de24f123608418dc1d248699dba92860bba46c711e251c2c2f91e1a072bd49f65c5710f1c971021058d07573b77775c8e2a79b10ed5ce79bbd4e8ad45c15f5679acd935518f46dc3a2964e646ae2bc5cfc8e6826c9037dba959e3c45369fc537c872a4bff47e7498ee16150f5acd0be312f06af0af16bdae6e7f5070362f9ae8b05e2d8dfa105ae1c8e96b8277093a65dc6ca0c6c33306a0d682c720ac86b62dd329c9f1b24ae27b361660f6d8e6a52bccfc35e29cae631d757567603a95e8d86c536416c7070ec6d6b552568c3f68bdb3ec9ad09020a0b0109004a818244142430290a1220054244200ba9a0a5714d0548cdb9097aa7148e282501b905a44b693320149022d25a67983a8fb84e81ce2bc92242a2330ea3eeb33c4bc5441877bc38071d1baef693b438ca327499ce78cbc4ed6e68a321dc9dd415c960300f99c0bc9239051f0ec299a42f7eb649f7f75d961200c1a52e7e7cefa47634ba48f6c6e1386b1800035ad54fe429e20a470581b3af1492a29bb0ea276102d00d48f8d54d934673a0013246de8458eeaebd8ab4a142c951cff0014e0c0dba2f49fcb7a109fe11f103f0f2b6170191da1bdefaad75cff001fc301eb6686f52375b74da871957839dadd247245bf27ae46eb0083a11a14ab9ef0363fcec2b2dd6e61ca6f75d02ec1c085d5316d25a1082c0290a5291000828291218884b68401c89e2b37391ca27f169b6123ad5509ad6513dd68dc794527e59a90712948737cc24e5b1db5d5412e3e5e72394385c408de1c4582d7348f70a373934c4db27fc549f9ddf7283887fe777dca841417208f24a6679ddeeffd8a6990fe677dca8247d6c9ce722c74c52f3d5df72b9be3f8a25c18492ddf5e4ba1cda2e5b8c7f7bf4546793503a3f1b1dd9959a9c0880282e9e15c9f07f4d2ea613a2e44d5b3db69dd16d8a501568dca76954c91ad3254d4e684c2792ada269913daaa6202d02a8e2e4680492a0d12bf6519165638587057a7c6463772a324cd77c26c2718b4ecaa724d5177fb33c496cf3444e85a5c077057a3af23f0de23cac7c4e06b3db0f4d57ae3b72bbb825bb1a3cde68edcd25e3b0489116ac102291484c029225b49690c442721023996786313fe58ff007271f0c4e37747f7257629cd0a7b99c4fe5f1fa38b3e159cfcf18aee528f09cdbf991d7b15da526346a52dcc92c10f47223c2737fe58fec53878424e73b3e8d2baea488dcc3f063f47263c20ee73ff00c53bff00c872f3ff00e217528a4f731fe2c7e8e55de0eff3cfd1a1709e2fe1be46284765c044c7663cc9dd7b31d9795ff69d4dc64675b30b4f6dd5595b7137e871c564b48cce122dc0745d1e6a1fcd73fc1276b3339e40d52f14e3d632c4c241206776cb993ecf4585aab2e6278b3af2c6df7775f651378ace2fd0e2073aa088f246d05d210ea1b5017d1694f2c3f84131c4071d7f81ff00737a0ab724893973cba2b613c4126ce652d28b1d9b55cbb5e1c7e66feaa6c8f6bd818fd49f5070bf6516d32e85ae8ddc5710ca0f55cde3e59253a3e81db7527136ba379121273d0e807b2b13629d918c8e2630b012e9037d6fb5055d8e72774ccd6f0ed3d4e71ed4a2f2cb0fa6ff0065319f10e249b02b4b1ba588bce8e0a4e5456a09959d20fc4425a69c1ecb6d73b5ed20e8dea5a2fecbc7e2019881348dccd8f29cbdd7ad60b10d96364adf85ed05a3f65d4d234e147275906b2264c50114916933d0a5050909486092d221001684968401a613c2686a5083942951b46e9ce4c4224392909a0a75a0430a54142614212bcfbc750c78a9da18e01f0b0b1c7f36abd0ab7f63fa2f3d660435f33dfea738b8d93b6ab3ea25513abf158b7cdb7e0e6785f066c80991c747115cb4eab5b19816f92e6b5bf08b6d0d6c2af847169783f98915d16b42e5ce91dd845233ff00e9ad786b9dadb46fc8a964e0f11d4b6dc2b557835cd1e822b7008ba4074a41d1b7c8d68154d9728a2083850d091f755f0f107ce5cdf8233408f98a7cde63c8639fcf5c9a2bf858325340a68dbdfaa8d925129f1bc279801ad41b50e0b12c2007535edd0de9f55af8d2d0ddc12561e2218c8b75661b770abaa64da4cb5235bf99bf70ab4e18df981ff4ea549061a070b2da77444985601a04c55665ccdb0e3f9bef4bd0fc30c230b00e8dfdd79f6246e17a4f0968104206c230ba3a2f272be43eb48b96912255d13982242952140024284243112275210146a0d1225714cb4ce50e2a307529f6a36ee5343f1c12a4290b91690d084a01414c2a403cae178a8b73db7bb9ff00aaedcbb65c6e2d804b2b4816d91c7b8b59756be875be1dd4d9cf62f0de5b80bbb6836ace164d9338cc5972fb9a254101d17399ddf26fc0f14998a9a869cd65b243d5598f5dd56cb5323958e680e6d93bace6e2710492e3e9e4d3c96a4f8a1c8ecabb6ddb0424272333118d908d8daad044f71b73b4bd42da18635ea2d0399be4aa4c00f85c0fd5262a6596900d8f64dc4623459be6936accedf483d94686a4567bb31eebd3f8447960846e4306abcdf86e0a4964c913733eb36a680039af4ae1b0ba38a363c82f6b69c46baae868951cbd7bb68b25214a0a16f39e3508291002a694a90a0609108401a44acae29c76286dbabdff0095bb0f72a4388cf18caecbe636f36c5ad3cc774cc1703823a21b9ddbe779b37d55b497670db735f5686e0f1ae2c76231150c405b5bceba956b03c42396cc4e0f02ac8d40be4b9dfed271c1984311bcd2b9b97a7a752a2fecef85cd144f74be964b95d1b79d56e51765b1c6e30b4ce878b41369261c8cedf89876785578671f0f22395be5c9b51d012b69aaae3f011c83d6c048d43b670f6284fc3212c56f745d3ff45891e00b3a04d909ad06bcbbac3e258a1f84969d645006fa15a7c327cd146e3cda2ebaa6e348219d3924ff00ea2a49c4ec5b3e361a9187e26ae5bc41c403315e6347a5f13330ff0010dd6978d30a59971517a5ed392503673791705caf13c689b21cb4e6839ab6713cd519a51d9b5f67a7f8cd15e48e783b8be1af46871391d344d945651a00371af354f00e0742a4f0ecb984d0ee1ed2e6df554a17163b5ebffc5873416c8c91b67ba19e517fe0d32ca29b8a9086d84e128210c75ac468319b3c97663202b9c3de1e4099ee637986f35a0f6f654dc43796c9ee0d88924c2e1b29a32b9c6c8b26ab92c8c5c048a60ca7913bab8fc76e003f40a2692e36a0c928afee1c3f879145ce24a9b15c87452b4d7d967cf21710d68b739c1ad1d49495c9d1175156751e0482dd3cc76a1137df73fa05d7859fc1f878c3c2c8b98199e7ab8eeb402ede286c82479fcb3df36c7521222d4c888e404d25382602a6a54243414912a4401ce61310e91b8783abdb75be46eb4bb26ac1e0dc2831de6137432c63a37a9eeb7c2d191f279ed2c2b9660f8d70cc7e19d9a3f308700cad5c1c74b0ab493e2a06c0d6c61ec6b5a1eecc3365ae43b2b90e21d3e22d9670d0e81e3e17cdb13dc04df113e002333b4bdc5c7c90d347373292373a6aa46bc130701441b1756330fa29172dc2b06f8f17e712d103e3cad20eb9cd7a4f75d568949532b8dae19e7dc49c633342ed0090bc0ea0eabacf0e83f878ec5696b3b8cc2d9a405ad19d9886439ba82db36b6f05330e664643bcba6bab6054dbb4658422b370331d870f648c3473b1c35eb5a2f2698558d8b496fd42f637301217947188409e768e52bff558b5495267b1fe1ec8d4a70f041c226c9344eb3598035dd5de2f0d4d20e561c396e2d49e1fc035c1f2bb5c9a4639661cd458a69bce4ddfc47736b337fd37136ebdc5ea135e172411c95a15662928aaee6df2503c90b1b446323718f0539d102b08631cddd0ee29dd41c49fe4359f0b4730a32e6058b2714079aa8fc7b8ec96d0fcb46b63b1400df7478623f331905fca5cff00b05865e49d56f783e463314d748e00163dadbdb31d95fa68a591599b5591bc723d2f35a7b542c5285d8671e3c8e4a9020a89223714ad291c1284050b696d35284124168452121d18324b34113331f54536a41b0e61d8fb15bd247f888da339646f1fc4cba39c0fca0f20b09b03e273a19edf13c64120d728f96fa2d8e10e6c70805e086b8b73f2216b92b479bc3719fa3461818c6b591b4358c14d68d973be23c637386c78738ac4c43335ad1e98f3680b8fecba30f07506c72e8a28a16b1ce73400e7fc446eea55ae0e845a7c9e5bc67c49297c5164f25b048d73d8ddcc97a9fd57a4e3f8888a0337f81b97bb9c3458b3f85a21889712e7b7ca958e12b64f949ad5bf65738a86e2206b236bb279b1860d8c81a08fb7742b6579e50ba8bf062c78d7c78706ee49a471bddd674b01747e1ec0f93080e1eb79ceeebd824870b0c6f6369ae988db7c8d1fa2d3214e52b33e0c552dcdd885fa82b91e1fe186628cf2c8f91b9a778686903d20eebab9450d7a2a2fc4b591063080e79375c87f554654ab93ada6cf93136b1f6cc5c2e16384ba288931b49a2fd493ccac7c6c392422bd0fd474be8b7a58ea88e4a0c761c48cee36f758a4d2e8e96e94ddc9db39f9b087e4fb2a13b083a8a2b62171069c35068ab32619af1a80aa9c13e5174326de19ca48a0734730b5f1fc39ccb2356f4e6b31ed59daa34269959c0720130b1590cea9c62a55b26915e262abc6672d0ccba1cc0dfb2be02c8e326ebdd3837647247eacf4cf05f881b3c619238676e809e602eb1a1784f05c6189e0fca77a3fcc2f45e11c7fe563c4942cb49d6975219ed72726585c5f1d1da520aab83c7b241a1a77369dd592aebbe88a18f4d09ee515a603c1417265a5010c05cc84ea424486f1ac03dedb888120d83b56b8742b030d2ceccd149877ba37de7005efcc52eb0c83a8479c3f30fbad29b470f26184ddbe19cd611f3e1c81abe0e8ed1ed6ae81d886e5ce5de9cb9bdfb7ba591cd3be537d5501876f980e66f96d1e9613a03d7ba7d8a18f67eaccbc461a7c4c999f5e50f8230ea1436cc54aee198e71d248a369f48cae34c6f6d16fb666f223e891f896b4125c074ad494a52a5e851d3c64fd90f0be1ac841165f23b57c8ef89c7fa2b33ced60b71fa0dd50c471127460a1d79ace7bc93a9bee565c99d2e8e960d1bf3c22ce2b1c5ffe16f4e65517483edada7161514acd165965723a30c4a2a922db4d8f70a2cbbf44dc1bec65bb23552bd42c9193c4b0fbbc0ec7bf75061e5ad0ad59c8235d963e4ca483ee3d909d127c9a0288593c438387596e8ee407357a09156e3fc53c98c06ff7925869fc8dfcca335689424d3e0e6e569692d35637a290c80aa0c6d9cc49366c9bd4f556e29584fa49be879acce2698e5f64c2315f458dc42224135adff25bb2565d14584c3871a70d2bf5508f65993f530307862e048f97973567052398e0e65870d6ff0062ae710e10f81c1f19390dea7e5ecaac2d235bbb5a533134777c1f105e1b2555b4ebdc2dd831ae6ee7305ccf85e4b8483f2be80ec56cb4a947238b23b533763c535db6fd0a52562349e468ad0c2e22f427d5faad78f32970ca678da2e00a40a36a902b9904854210a23260d70a14d701b13a151be3713f0b1a06bd493d141e7cb169336c0d03dbb1ee55a8316c7fc2e06b7ecb5f4712304b8e8a32e1dc4dff000dbaf3255797d2f04e57017a0dafba77119848ea048636e80e67aaaa19d167cba96b847430e8955c8b937107b85001836f48175eeab175f34c1d14991629e472ecdf8b1431aa8aa12d34a900400aa6cb684684d7809e021c14466562dd24633462c8d0f521470f1493e781faf31fd1694813c38526989a2b616a56e62d735b7a076e4a6f1082c581ab47dfb2d06f2f6d123821b048e7da572fc7b105f3b87267a07b0dd7498c1e44843b58a4b2d71f91df97d972908f36491c7a9fd50dda24b815ad154a2fc3e53986e2c807657ff0a5bdd4ad8da45114540652e0f8f1317348cae1b01cfaad68c0682e3a06efdfb05cbe223387c434ec2c1bea0e8b7718ecd4d074f89ddfa28ede6cb14beb4cab8c9df2925d61bf2b2f46ff0052a3645c8ec55c661d4ecc30e8a4565af0c92d32339101df65d0b7dd73b133cb21c39684750ba281c1cd0e1b14080a4f32a8f31b290b540e426d31b568dec1e203da0f3d8fbab16b0783cfeb2dbdc1fe4b7015d184b745332c954a87da116852a159160f8bbbcb63a68c8f31c58c6d5b9cdeae6aafc525832830d071243b2d8aec42d82d61735ee003d9794f216b91e22ca92401d9bd649775255b92548e7e1c7721e251d54ac77759461772295924ace56b148e9a368290154b0d8bcc3bf4e6ad00a965887b5294d6a52a0c90028a4948210045b82aa3e52d78b16c3a1ec55c8f9a85f1dd8ea84059f64e2555c2c87e13bb74f7569a50c119fc5b0be6308dc8d42e6701800d2ef4d1275eebb6202c6c5c45a4e9a1d4289233668828461acecacd5953c509401958de1225003b5ca41be62b97b2a98439df20af80e5fa2e83154d047320aa183c2b5b9881abb5250208e252f94a5cba5a65ea90c40d56b85cb9498cec6cb0f4ea146d6a64add88dc6a1340cd92141337e8a6c34a1ec046f5a8e8535edbd1368132be04d4ecfa85d2dae6f04dfe347a6c5dfa2e8815b307e851917d87da136d0af2ba345e34363604ae5a38c3bd5be6377eeba927477fa5dfa2e02099ecee390f74f51666d379367caa52062661e60e1dd4a0ac4db3722a4f850756e8ee549f87989d0fa48dc7eeac01f7506260cc411a10a16489736bba901541b291a39a6c2b513ed458d13829b24a055f34bbaace19a403603f74864b13b7f74e70d6d44372a622d2021c432a9e371bd730a41202011cf9a5254101ca4b796edfdd00580a9f15c3e760d6ab9f6570143f6d52198904634a561c404c738334daad6762262e3dad0315f2e67f6e691a2baa485b5f74b23a9d55b8be7481124a744c859cd389b1af2520d1218e2a2282eb4b4980bc3a5cafcbafab6e80ad47e8561ce08d46e082b670d267607751a297647c8dc3b4fe2233cb2bad6d82b22277a9a7bd2d50b5607f5a2ac9fb0fb424a42bc89a53fc2eff43bf45c33366fb04214b39974bd32fe195b4a85859b50e8f74e910851248ab2ee9cde48428b19606c5526fc684243278f73eea53b2108011bb28e6dd895080257ee535c84288cc5e2bbfd1506a442892260897e26fb14214842c69f2a44240318a5284263219363ec55df0fff0075fef7210a48832c1feab5309f0a10afc1d9199690842d244fffd9);
INSERT INTO `timages` (`ID`, `EmployeeID`, `ProfilePicture`) VALUES
(11, '14-10355', 0x89504e470d0a1a0a0000000d4948445200000200000002000806000000f478d4fa000000017352474200aece1ce90000000467414d410000b18f0bfc610500000009704859730000406c0000406c01688a05970000001974455874536f667477617265007777772e696e6b73636170652e6f72679bee3c1a0000598d49444154785eeddd799054d5fd36f05fd0501a8db12a56c53fa8542c2b954ad52faf794da52a6fc5696064df57911d141551115c50710918c5051736875d04451459145c00954de32e127141d935a2a8a0466136f4bcdf6fd30d77ee3cbddceebbdfa7ab3ea59ce9becbb9e79ce74c4ff73dff638c21a290ab7ba1e244d14c9c252a456f315cdc28ee13f3c512b152ac16ebc5abe26df19ed826f6882fc437e2a0389ca1ffaf65fa337d8e3e575fa3afd56de8b6749bba6ddd87ee4bf7a9fbd663d063d163d263d3633c119d0311850b2c24227f48583615678a566298b85d2c142f8acde25371489888d163d663d773d073d173d273d373d473d5736e8aea8488fc010b89c81d12724dc4ef440b31548c170bc446a101f9a340019a047aee5a075a175a275a375a475a575a674d509d12913b602111392781759ad0b7c2af1473c59b228abfbd8785d69dd6a1d6a5d6a9d6ed69a8ee89c839584844b94908e9dbf6faf7ee8162a25825f60a1462e43ead6bad73ad7bbd067a2df8e70422876021111d23e1a27faf1e2466892da25ea060a2e0e835d16ba3d748afd599e85a12d131b09028a924388e177f15a3847ee2fd73810287c24faf9d5e43bd967a4d8f47d79c28a96021515248289c22da8a5bc55aa15f89436142d1a7d756afb15e6bbde6a7a036419414b09028ae64d0d74fe5ff4de827ce5f1749fe147ed2e9b5d736a06d41db04bf754089020b89e24406f6d3c560b148ec17280c88b46d681bd1b6723a6a4b4471020b89a24c066ffd3b7e4a4c109bc44f020df844b9689bd1b6a36d48db123f3f40b1030b89a24606e85f09fdcd6da9f84ea0419da854daa6b46d691bfb156a834451030b89a24006e25f8afe6285a81568e026729bb6356d73daf67e89da265114c042a2b09201f724d1472c13d5020dd0447ed136a86d51dbe449a8cd1285152c240a1319587525bc9e62b1e0d7f428acb46d6a1bd5b6ca151129f4602151d06400d5afebb5138f8aef051a7089c24adbacb65d6dc3fc7a2185122c240a8a0c96ba9efc2d42d7a547032b51d4685bd636dd0cb579a2a0c042223fc9c0789ce822568ac3020da24451a76d5bdbb8b6f5e3505f20f2132c24f2830c826788dbc467020d984471a56d5edbfe19a86f10f9011612794506bc9f8b5e628de00d7a28e9b40f685fd03ef173d46788bc020b89dc2683db6942ff0eba4fa0819028e9b46f681f390df52122b7c14222b7c860f67b315d1c1268d023a286b4af689ff93dea53446e818544e592c1eb1cb15c70b53da2d268dfd13e740eea6344e5828544a590814a3fcdaf7fcb7c4da0018d884aa37d4afb16bf3d40ae8185444ec8a0a4b7e7bd42ec1068f0222277ec14dad778db612a1b2c242a860c42a708fdd0d20181062b22f286f639ed7ba7a0be49540c5848948f0c3afa1bff7562bf40831311f943fba0f645be23408ec1422244069913c468c1aff211858bf649ed9b27a0be4b84c042222b19549a8a118277ec230a37eda3da579ba2be4c64050b89940c22c78b61820bf310458bf659edbbc7a3be4da46021259b0c1aba14ef40b15da0c18588a241fbb0f6652e494c8dc0424a2e19285a88cd020d2644144ddaa75ba03e4fc9050b29796470d095f99666060b228a27ede35c8190d2602125870c06278b09a246a0018388e245fbbaf6f993d19840c9010b29fea4f3ff4c0c119f0b34481051bc69dfd731e067688ca0f88385146fd2e1ff2ede14685020a264d1b1e0ef68aca0788385144fd2c97f2b16653a3d1191958e0dbf456307c5132ca478914eadabf45d230e0ad4f18988948e113a5670d5c1048085141fd291ff2cde12a8b31311213a66fc198d29141fb090a24f3aafdeb7ff4e512f50072722ca47c70e1d43b8be404cc1428a36e9b07a339f8f05ead444444ee858c29b08c5102ca468924e7aaa982d7e12a82313119542c7141d5b4e45630f45132ca4e8918ed943ec15a8f31211b941c7981e680ca2e88185141dd2194f17cb329d9388c80f3ae69c8ec6248a0e5848d1201db08bf82ad3218988fca4634f1734365134c0420a37e974bf1033329d908828483a16fd028d55146eb090c24b3adad9626ba6e3111185818e4967a3318bc20b1652f848e76a22c6883a813a20115190746cd231aa091ac3287c6021858b74a86662ad409d8e88284c74ac6a86c6320a175848e1211da9b73890e958444451a063566f34a65178c0420a9e749e93c5bc4c6722228a221dc34e46631c050f1652b0a4c3fc417c90e940444451a663d91fd05847c18285141ce928ddc477998e434414073aa67543631e05071692ffa473e8a7fc2708dec79f88e248c7361de3f82d81908085e42fe910bf16ab05ea34444471a263ddafd15848fe8285e41fe9087a639fdd998e414494043ae6f1c641018385e40fe900434475a643101125898e7d43d0d848fe8085e42d69f44d4555a613101125998e854dd15849de8285e41d69e8bf11af641a3e11111d19137f83c64cf20e2c246f4803ffa3d89569f04444748c8e8d7f44632779031692fba461b714df641a3a111135a663644b348692fb6021b94b1af420c155fc88880ad3b172101a4bc95db090dc230d799ca56113115171c6a13195dc030ba97cd278f593fe0b2c8d9988889cd13194df10f0082ca4f248833d55accb346022222a9d8ea5a7a2b196ca030ba974d250cf105cc98f88c83d3aa69e81c65c2a1d2ca4d24803fd8bd89769b04444e41e1d5bff82c65e2a0d2c24e7a4619e23b88c2f119177748c3d078dc1e41c2c2467a441b61607330d948888bca3636d6b34169333b0908a270db1aba8c9344c2222f29e8eb95dd1984cc58385541c69807d457da6411211917f74eced8bc6662a0e2ca4c2a4e10d133f661a221111f94fc7e061688ca6c26021e5270d6e94f829d300898828383a168f426335e5070b2937696837591a1e111185c34d68cca6dc602161d2c0eeb2353822220a8fbbd0d84d182ca4c6b461d91a1a1111850f2701458285d4903428beed4f44141dfc73401160211d230d493ff0871a18111185173f1858002ca423a401e957fdf8697f22a2e8d1b19b5f11cc0316523afcf5263ffc9e3f115174e918ce9b05e5000b934e1a8cdede9777f823228a3e1dcb79db600016269934145dd887f7f627228a0f1dd3b980900d2c4c2a6920baa42f57f523228a1f1ddbb994b0052c4c2269187f115ccf9f8828be748cff0bca8024828549230de20cb12fd340888828be74ac3f036541d2c0c224918670aaf820d330888828fe74cc3f15654292c0c2a49006d054accb340822224a0e1dfb9ba26c480a58981472f117581a03111125cb02940d49010b93402efc385b432022a2e419873222096061dcc9051f646b004444945c835056c41d2c8c33b9d02d459de5c2131151b26926b444991167b030aee402ff517c93b9e0444444599a0d7f44d91157b0308ee4c2fe46ecca5c682222223bcd88dfa00c89235818377241f5eb7eaf642e301111512e9a1589f87a202c8c1bb99855968b4b4444944f15ca92b881857122177288edc2121111153204654a9cc0c2b8900b78b6a8b65c502222a26268769c8db2252e60611cc885fbb5d89db9904444444e6986fc1a654c1cc0c2a8930bd644acce5c402222a25269963441591375b030eae4624db05c3c2222a2724c40591375b030cae44275133f592e1c111151393453baa1cc89325818557281fe20becb5c30222222b768b6fc01654f54c1c228920b73b2f82073a1888888dca6197332caa0288285512417659ee52211111179611ecaa0288285512317a4b7ed0211111179a537caa2a88185512217a2993860b9304444445ed2cc698632294a606154c805d0effbafcd5c10222222bf68f644fafe00b0302aa4f2c7582e0611e550f37c85d9f1788579716acaccb93965c65e9232fdba374fd3ffd732fd993e479f8bb641448d8c41d91415b0300aa4e2f53eff75960b4144a256027cebc20ab3f88e94f9e7e52973619fe6a6556573934a15479fabafd1d7ea36745bba4db42fa284d30c8aec7a01b030eca4c27f21b6662e0051a255afa930ff9e5f611eb93565c60c4b998e6d70b09743b7a9dbd67de8be749fe858881248b3e81728abc20e16869d54f60c4be51325ca0fab2acc5b732bcc83b7a4cca82129d3e65c1cda5ed27deabef518f458f498d0b11225c40c945561070bc34c2aba8bade28962eddb672bcc2b335366c6d8941931a0b9a96c894339487a4c7a6c7a8c7aac7acce85c8862ac0bcaac3083856125157cbaf8ca52e144b173684d8579734eca4c97301d767e73d3a2390edd30d363d663d773d073d17342e74a14239a4da7a3ec0a2b58185652b9cb2c954d141bfae9fbc5138efc0dbf6d2b1caa51a6e7a4e7a6e7a8e78aea80280696a1ec0a2b58184652b13d6c154d1459fb9fae302f4c49993b47a54cafce3834e34ccf59cf5deb40eb02d5115144f540191646b0306ca4424f157b2d154c1429faa9f94d0f56985937a5cc257d9b9be6117c5bdf2b5a175a275a375a47fc8601459c66d5a928cbc20616868d54e66c4be51245c2ee272accd23b53e6868b53a65d6b1c7ed498d695d699d69dd621aa5ba2909b8db22c6c6061984845b6103f592a962894be7da6c2ac9b96321347a74c9fae38dcc839ad4bad53ad5bad6354f74421a399d502655a98c0c2b0900a3c417c9ca950a250d15be6fefba10a33f79694b9b47f73d3b2050e30728fd6b1d6b5d6b9d63d6f5b4c21a6d97502cab6b0808561219577a7a5328902f7e9d20af3e4dd2973d3706feeb847cee835d06ba1d744af0dba664401ba13655b58c0c230908afbb3a8b7542491efbe7bb6c26cac4a99fbae3eb2780e0a210a0fbd467aadf49ae9b543d794c8479a617f46191706b030685261c789b7321548e41b5df4e6bd0515e6a1712973f9c0e6a6926feb47965e3bbd867a2df59a7241230a8866d97128eb82060b832695758da5f2883cb577798559714fcafce3d294e9dc0e8709459f5e5bbdc67aadf59aa3b640e4916b50d6050d1606492aeab7e2a0a5e2885cf5fd7315e6e5192933f9da9419d8138705c59f5e7b6d03da16b44da0b642e412cdb4dfa2cc0b122c0c9254d2224ba511b9e28b272bcc931353e6ba6129d3dac1daf8940cda26b46d681bd1b682da10519916a1cc0b122c0c8a54d0df6d154654b28f175598f9e352e6927ecd4d7330e81321da56b4cd68dbd13684da165189fe8eb22f28b0300852313f136f5a2a8ac811fd4eb8ae4d3f794cca9ccf1bf1904bb42d699bd2b6c5fb0e509934e37e86323008b030085229432c954454145d775e1794b9f5b294e9d8160fe0446ed136a66d4ddb9cb63dd426890a1882323008b0d06f5221278bcf2d154494d367cb8edc63ffea0b52a6b2251ea889bca66d4fdba0b6456d93a8ad12019a7527a32cf41b2cf49b54c6044be51035f2e123476eb93bac0f1e8c8982a66d53dba8b655d486892c26a02cf41b2cf49354c419a2c6523144e6d09a0af3daac2377e04be27af9146dda66b5ed6a1bd6b68cda38259a66de192813fd040bfd2495b0d452299460079eae30ab26a5cc2d97a64c7b2e9f4b31a16d59dbb4b66d6de3a8ed53222d4599e82758e817a9005dea17550c25c4274b2acce31352e6cac129aea647b1a76d5cdbbab6796dfba84f50a204ba64302cf4839c7813b1d952119400b562cb820a33f3c69419d21b0f924449a17d40fb82f609ed1ba8cf50ac6906364119e90758e80739e981964aa0183bb8bac2bc343d65ee1e9d32dd3be2819028e9b46f681fd1bea27d06f5258aa5812823fd000bbd26277cbcd86ea9008a99af57569867ee4b99b197a44cdb5678c023224cfb8cf61ded43da97501fa3d8d02c3c1e65a5d760a1d7e46487594e9e6242efa1bee8f694b96c4073d3a2391ed888c819ed4bdaa7b46f719d82d81a86b2d26bb0d04b72a24dc51ecb895384e92a6afae966bd210a439fc85bdac7b4af699fe30a86b1a299d81465a69760a197e42447584e9a22a8f6f90af3faec94b9fd8a9469c7b7f78902a17d4ffba0f645ed93a8af52a48c4099e92558e81539c113c4679613a608d195d1aa6e48999e9df0804444c1d03ea97d93ab17469a66e309283bbd020bbd222737da72b21401fb9e3af277fd0b790b5ea248d0beaa7d56fb2eead3146aa351767a05167a414eec24b1cf72a21462fab6e2b517f2effa4451a57d57fbb0f665d4c7299434234f4219ea0558e80539a9eb2c274921a43722593b2d652eee8b0714228a26edd3dab779b3a148b80e65a81760a1dbe4844e11fb2d274821a3f728bf7c201e3c88281eb48f733d82d0d3ac3c0565a9db60a1dbe4646eb19c1c85d0ca7b5370c020a278d1be8ec6000a955b5096ba0d16ba494e44fff67fc0726214524fdc9132955c90872896b46f6b1f477d9f424733d3f3cf02c04237c9495c6139290a395da1ec9f97a74c737ef88f2816b42f6b9fe6ea83917305ca5437c142b7c8091c27765a4e882262fb6315e6c64b6422000614220a3fedbbda87b52fa33e4ea1a7d9791cca56b7c042b7c8c1f7b29c0c45d08ec72bccd4eb52a6535b3cc81051b8685fd53eab7d17f5698a945e285bdd020bdd2207ff9aed6428a2747952bdff38bf2940144eda37b58f7229e158790d65ab5b60a11be4c0cfb19d08c584fe6631650cdf15200a9af641ed8bfc6d3fd6ce4119eb0658e80639e8e5b693a098e1bb0244c1e06ffb89b21c65ac1b6061b9e4807f2f7eb49c00c5dc8ec72acc64be2b40e419ed5bdac7b4afa13e48b1a559fa7b94b5e58285e592839d6e39784a10fd8de4b9fbf9ae00915bb42f699fe26ffb89361d656db9606139e4404f13872c074e09f5c9351dcc824b5a99213df1c04644d890decdcd82f1fcee3e1da5997a1acadc72c0c272c841f2b6bf74c4e5dd4cdd79bdd3b60def64660eaf34e777c1031e51d29ddfb5b9997963ca6ce39afe84b97e7b6058582a39c09f0b2ef94b4758260047f5ed65debdbc83993cbca5e9de110f844449a17d60f2b529f3ee7cd07f881ad26cfd39cade52c1c252c9c1f1c63f740c9a0058d40eea69de187faeb97354ca74e487072921b4ad6b9b7f634ecad43e0ffa0d516eaede180816964a0e6e8ded6029c90a4c00d22674483ff7d09a0ab3b12a65c68d489936e7e2819328aab44d6bdbd636ae6dbd515f212ace1a94bda58285a590033b43fc6439504a3a071300abef9fab306b26a7ccf517a54c654b3ca012859db65d6dc3da96b54ddbdb3951093463cf40195c0a58580a39a8db2c074954f204c0eac0d31566c53d29336a48cab4e00a851472da46b5ad6a9bd5b68bda3451996e43195c0a58e8941c90aefaf799e500895c9900587df16485797c42ca5cd20f0fbe4441d136a96d53db286abb442ed2ac7565954058e8941c4c17cbc1111de1f204c04abf1f3d7f5cca0cee85076422af69dbd336c8efea5300baa02c760a163a2507b3d27670449e4e00ac3e5e5491fefe749fae78a026728bb6316d6bdae6505b24f2c94a94c54ec14227e4409a89c39603233ac2a70980957e9f5abf57ddad031ec0899cd2b6c4efea53c868e6364399ec042c74420e8277fe232c800940967ebf5abf679dbec7401b3cb013e5a26d86dfd5a7902bfbce80b0b05872004dc41ecb01111d13e004c04abf77bd81f718a002b2dfd5d7b6c2efea530468f63641d95c2c58582cd9793bcbc1103514920980957e1f7bf5e494b9fa82140c014a1e6d0bda26f85d7d8aa076289b8b050b8b253b7fd4763044c784700290a56baaa330a0e4e1fafa14618fa26c2e162c2c86ecf844f1bde540881ae20480228013008a30cde0135146170316164376dad37210448d71024011c00900455c4f94d1c58085c5909d2eb61d0451439c00500470024011b718657431606121b2c393c441cb011035c609004500270014719ac527a1ac2e041616223beb63d93911c609004500270014037d505617020b0b919d2db3ed9ca8314e0028023801a0185886b2ba1058988fece897a2dab263228c13008a004e00280634937f89323b1f58988feca4bf65a744b97102104aad2a9b9b0e6d5a986e1d2b4db70e2de4ff8f94a1e7260127001413fd5166e7030bf3919dacb0ed9408e304c053ed5a3737037bb731970cea6cae18d6d38c1adecf5c79e94073ef6dd79a1796cf318307f43503faf6317d7af734ddba7631eddbb533959595705baa79f316a66d9bd6a673c776a647d78ea66fefaee682013dcca5437b9acb2fec61460eeb66ae18dac95c3aa8bdb9f0fcd6a65ff74ad3b615de569470024031b10265763eb03017d9c1af44ad658744b9710250b62eed5b9ac17dda9b1117f432a324dc478db8c08cb864a81924e1deb163c746cf6fddbab5d9b7ebdfe6d0573b1afdcc0b3a69e8dea5a34c147492d0d35c79613773d9e00e66c879ade4d85bc0d7840d270014139acdbf42d99d0b2ccc45363ed8b233a2fc380128dab995cdcd05fdda9b31570c3063afbed48c1c7191fcd6de153e379fd955f79bc3df7de2db04a0907b6fbdc67cb0b6caac9c3ddadc73436f7371bf56e6dc96f8b941e10480626430caee5c60612eb2f1a5b69d11e5c60900d4b2457333e8bcb6e6ea117dcd0d575d22617fb1e9d5a33b7cae13fa36fff7fb3e0ecd04a04ba70ee6eb0f569b9a3d1b1bf861c70be6bde7a79aa555579891177432fd7a54a6eb046dc30f9c00508c2c45d99d0b2c4464c3c78bef2c3b22ca8f1380b416cd9b9ba17d3b986b470e4dff667f5eaf9ef079e57a6af1fc74f8876502b072e19446e16f3764409ff4733b756c6f465edcd7dc7885be4bd03a5d67f6ed798513008a11cde8e3518623b010918da62c3b212a2cc1138036ad9a9bb123cf37cf2c9a620e7cf2aee9ed51e8670d1ad0cfd47db33b341380cb2f1e0c03df2e3b01b0ebd1ad931931b487b9a85f5bd3fadcc63f7713270014332994e1082c4464a3136c3b21ca2f611380ceed5b9a0b07f6308f3d78bf39f4e5f6a361acbc9e00bcb2766583fd053901a86c59693e7e75290c7cbb5c1300bb5edd3a988bfa77f0e483859c0050cc4c40198ec0424436bac9b613a2fc123001e8d9b932fde9fc81fd8e04d9c373ab1a0471969713806baf1ad9687f414e00aa26de0cc31e29760290d5a2454b33e2c23ee6c62b7a9a5e5ddc990c70024031b3096538020bed6483a78b9f2c3b202a2cc61380de5d5b9921fdcf4b0752b66ce284f18d8238cbab094097ce9dcc97bbb734da5f501380de3dba9aefb6bd08c31e713a01b0ead6b9a31973599ff48708d1cf8bc50900c58c66f5e928cbed60a19d6c8c5fff23e7623801e8d7b39de92521672fd7dfc2ad7f83b7f36a02f0f20b2be0fe829a006c7872360cfa5cca9900580deadbd5f4ef792efc59219c00500c15f575405868271b5b64db385161319900341703cfeb683a831befa80b870c3afaf5bb5cbc9800dc77f76d705f2a8809c0f5a387c390cfc7ad094096de0db17fcfd6e96b867e8e70024031b40865b91d2cb4920d3511fb2d1b262a4ec42700952d9a9b6103bb9b366ddac09f2bbd1bdfe73b36c310b6727b02307860ff74c8a37d29bf27007d7a75335fbebf0a867c3e6e4f009e5c707ffabfdd3ab737970de998be86f6e7d871024031a499dd0465ba152cb4928dfccdb251a2e245780270e5453d4dbfbee7c19f59ad7b6e190c603b372700ad5ab532dbde7d05ee27cbcf0940bbb66dcc47af2c81015f889b1380f37a7633ef6d78bc41d9d001bdcca80bdb3728b3e3048062ea6f28d3ad60a1956c64bc6da344c589e00440efbd3ff2d20be0cfeceebaed1f307c113727004b16ce85fbb0f26b02a06b016c5c3107867b31dc9c003c32fd0ef3fec6861380ac11437be6fc0a2127001453e351a65bc1422bd9c8ebb68d1215276213804b87f64aaf98672f47faf5ed637ed8b70d862fe2d604e0baab47c1eddbf935015838e30e18ecc5726b0230b06f6ff3c3ce75392700aa5d9b3666e4058d3fc7c10900c5d4eb28d3ad6061966ce014f1a3658344c58bc80440d7c2bff6ca8b1b84423e2d5b569af7dfda008337173726007aafffaf3f791f6edfce8f09c0acfbc7c15077c28d0980be0bf1d69a87d3dbcb370150fadc7f5cd53f7dcdb3659c00504c69769f82b23d0b1666c98bdb5a3646e44c0426009ddab530c32f1a72340c8a31f18edcdff7cfa5dc09807e10f1ddd7d7c26d235e4f001eae9ad028cc4be1c604e0f69b461fdd5ea10940d69597f44b5f7bfd7f4e0028c6daa26ccf828559f2e25b6d1b232a5ec82700e7756b65fa9edfbb5138e4d3bad591f5f651e8e653ce04e0dc73cf356f6c7c0e6e3717af2600fa1bf4130fded320c4cb51ee04a05387f666df7bc7be7d50ec04400d3cbf8739af6b4b4e0028ce6e45d99e050bb3e4c56b6d1b232a5e882700bb1657984e1d3bc060c867dafd77c1c02da4d40980feb961e39a27e136f3f16202505959699e7eb4f00a7f4e943b01786ac1a406db733201509d3ab44db705d4468862602dcaf62c58a8e485bafcef41cb86889c09f104e0eb95f9bf0688b46bd7ce1cf8cf0730700b296502a0bf6daf59f938dc5e216e4f00069cdf2b1daed6b07543391380c9778c6db43da71300b5ef29dc46886240333ce7f2c0b050c98bfe6ad9089173219e00d40aeb7dfc8b5135f96e18b6c5703a01d0c9c6fad5cbe1b68ae1e60460e2add73ababfbf13a54e00f498d0f64a99001c5c8ddb08514cfc1565bc82854a5e34cab6112267423c01505d3a77868190cbc7fffe170cdb62389900e85dfe767ff806dc4eb1dc980074e9d4c1f1bdfd9d2a650270f7b86b4cf5ee0d707b4e2700adce3d17b60da2181985325ec142252f5a62db089133219f000c1ad00f860232b07f3f18b4c52a760230fee61bccc12fb7c36d3851ce04a06be78ee94ff97ffbf10b3064dde46402d0a17d3bb3faf107e076b29c4e00744541d43688626409ca78050b95bce873db46889c09f904e08a1197c050401e9a3515066db10a4d00f4e74f2f5b085f5b8a522600ddbb76328fcebcd3b3b7fb91622700a3465c60feb3f969b80d2ba7138041fda40d82b64114239fa38c57b0505e70a66d0344ce857c0270fbf81b612820bb3f28ef2df95c13803ebd7b99a79e58606af6ef82af2b55b11300fd1add2d632e4f7fbafffb1d6b61a87a29df04a0b265a5b9f1ea11e95b0de77acbdfcee90440cf1db50da2983913657da302254f1e647b319173a19e0034372b963c0c43c1ae63870e30649dc84e00f493fdfaffd75e3532fd1b7fed0177833f2bd704a043fbf666f8c5179ab933269b2d6fac2b3a58bd629f00e8dbfc170ded9f7e27c2fafdfe62399d00cc7fe076690b295bdb208a9d4128eb1b152879f22cdb8b899c0bf304606d2bb367eb9b3014ec2e1f71090c5927d6af5a66de7f6bbda3f503ca51f7cdeef404e7a5179e4aef77ef8e774cf5d73b1b3d0f85a89f5e5c3ac3bcb4726e7a35c16f3e2aff33074e2700baefba175be03642141fb350d6372a50f2e42db617133917e609c0fa23bfd577efd60d0683d5fd136f6f149c71814234ca9c4e00f6fefb19990cf29b00147b5b50d6372a90273615f59617129526cc13800dddd20138eea6eb603058e9dfe8edc119172844a3ccc90440bfe6a8afa95bdb06b711a2f8d04c6f6acffb06ff50f2a4b32c2f222a5d9827002ff74907e0734f2e82e160f5eaba671a05675cd80334ea9c4c00f49b05fa9aba75ed711b218a97b3ec79dfe01f4a9e34d0f622a2d2847902f0af01e900d40fcb75ecd8788d782b27abf0458d3d40a3cec90460ea9d37a65f53b7be136e2344f132d09ef70dfea1e449136d2f222a4d982700af5e783404a7de77270c88ac1defbdda2034e3c41ea051e76402f0eca269e9d7d46de88adb0851bc4cb4e77d837f2879d22adb8b884a138609c0862ea6fe9deb4dfdfbf798fab7af36756b2b8f94bf7eec93fdfa1d7ffd7a1e0a09f5f98ecd0d42334eec011a75c54e00cead3cd77cfde19af46bea36763fd2265e6c696a5fbbd4d46ebad9d4be7eb9a95bcfbb0452acacb2e77d837f2879d25edb8b884a13e004a07ecb047378dfeb8d43efab7f9bba977aca04e0d206e5d78c1e098342edfff4fd06cf8d137b80465db113809baeb9ece86bea36f648bf0b50b303dc6970db3253fbd6f5b08d1145cc5e7bde37f8873ce134db0b884a17c404606d6b53bfeb091876477d2e83fe9b573428d3b7f975ed7d14169f7ef45683e7c649a3c08bb8622700d6458eea5e3acfd47cfc5883edd8d5be5fc5af0b521c9c66cd7cfb04a0d2f664a2d2f93d01d8d8cd1cfea2b8bfd7d77f3ca751d9a489b7c3b0f870d3c646cf8d0b14765156cc0440bffe7770e7faa3afa97d677c836de4b46d89a95bdf19b73da268a8b466be7d0270a5edc944a5f3790250ff69f15fd7abffecc54665dfeedd6a3a77ead42830de7c6955a3e796436fffabcbfdbefcc24ab368fe2c73cf1de3cd8dd75d63a6dd7f9779ea89f9e6ed97d7987dbbde85af751b0c3a977db6f969f3faaaf966e9bc7bcde43bc69ab1575d6aee1e7fad7974e65de9fbfcef7ce3497368973bb7242e6602f0f89c890d5e53bbf5a106ffcea7f6c30761db238a882bad996f9f00ccb53d99a8743e4e00eadfb901065c4edfe025775f5bff8c69d1a26583c0d0dbf8a2e73aa5b7e25df6d83cd3b37bf706dbcfe5b24b2f366fff6b35dc965b50c8b9e59567e6994b2e1800cfcdae57f7ae66f9fcfbcc0f3bd7c16d15abd00460e8c0f365b271ecb7ffb45dce6e415cfbfa48d806892260ae35f3ed1380376d4f262a9d5f1380f5edcde1fdee7d50efb105b31a84c6d34b1f81cf2b96aef4a7bfd9f7ee997f49e05cae1831dcbcf3caf370dbe54201572efd6dffd26183e0b914725ecf6e66c5c3931abc45ef44be09807ed363d30b8fc0d739b27395a95bd716b745a2707bd39af9d6f06f220e599e48541e9f2600f5efde0ac3ad1c136ebdf96870e884003da718fa6785e1170f6b1044a55a386f06dc473960c09561ee947fc26377eab28b079b031f3d0ff7914fbe0980fef901bda614b56f5d0bdb2251c869c637411380df599e44543ebf26003b16c2702b47cdfe9de965733538e6544d82cf29e4bbcf3f32430797f69b30a2bfc13ebbfc51b8af52a1702b95be858f8ebb54170de9e77885403401d07a5b38e30ef8fc52d56e990cdb225104fc0e4d005ad89e44541e9f2600f0fbfe2ef86acf1633b07fdff4b703d0cf0bd10ff7d9c3a85cfa55c5d7373c0bf7570a146ea558ffe46cd3a245ee9b29956ad284ebe1fe72b14f00dab669dde02b7faed9b60cb645a20868812600436d4f222a8f1f1380756d25c8f6340a36b77cf39f0fcc538be7c39fe5f3d1e697f3de5db01cfa9900b4cf52c0702bc1c5438bfbb09f533aa9d8f6da32b84f64ebbf9e307dcfeb915ee8e7d199779a7defad82cf2bdf86f43d27609b240ab7a1680230def624a2f2f83101d00f0082600bdacca9f7c04053fa5b7cef9e3dcc88e1179971375d6faa264f344f2c9c6b36ac7ed2bcb276657a8542fd7ae0cca9f79abb6f1f676e1833daf4e8deede8ebf55b0a5fed790feed7291c6ece7cba696583c94ef7ae9dcd0d570d37778dbbc6ccb8f71fe9affb3df3e854f3f2cab9e6c5a533cde373ee36d3eebad1fce3bacbcda5c306a6bf01d0b265c36f5e58cd995ce4f7f47d56b78ecb0853248d47138005b6271195c7973f01a424c8bc7b07a054170fbba041880dbb608884fc1cb377c73ba6ee9bddf03585ecd9faa659b9e46173fbf89bcc4bcf3f059fe3140a36a79e5f32c3dc76d368b3e2e1c966d79b4fc2e714a25fcdfb64d38af464e18281e737a83bfd40207a4db036a4db1e6e9344a1b6004d0036da9e44541ebf3e03e0e25700dd326860bff46fedfadbfdf62de15d4d10875bf03e7cf90933e58eb1a66be78e66d8e0bef03981d2af0282b64814011bd104e053db9388cae3db87005f83e116a4f7df5a5ff26ffa7e82e116227a87c077d72f823f0bd4b6a5b02d1245c0a70d260052d054fc68790251f9fc9a007cf6020c372a0c861b15b6f561d816892240b3bea9750270a6e58744eef0690250bf67390c372a0c861b1554fbc14cd8168922e24ceb04a095ed8744e5f36b02b0e361186e54180a372aac76cbfdb02d1245442beb046098ed8744e5f36b02b0b50a861b1586c28d0aabdd7c1b6c8b441131cc3a01b8ddf643a2f2f9350178ff2e186e54180a372aacf6ed1b615b248a88dbad138085b61f1295cfaf09c0e69b60b8516128dca8b0da3746c1b64814110bad1380176d3f242a9f5f1380b746c170a3c250b85161b5af5e0cdb225144bc689d006cb6fd90a87c3e4d00ea5ebb10861b1586c28d0aab7bb93f6e8b44d1b0d93a01e04d80c87d7e4d003c5e1028ce50b851215c0888222f7d33a0ec04e090ed8744e5f36b02200e7ff9260c38ca0f071ce5b57d396c83441172283d0190ff39d1f6032277f83801a8dfb518061ce507038ef2aa7d6f1a6c83441173a24e009ad90a89dce1e704e0bd3b61c0517e28e028bfdab7c7c236481431cd74027096ad90c81d7e4e00deb804061ce587028ef2abfdd760d8068922e62c9d0054da0a89dce1e30420fd41c06fc3bffa5ed8a080a37cd6f303801417953a01e86d2b2472879f130071f83fab61c8516e38e428a7adf361db238aa0de3a01186e2b247287cf1380fa2db7c190a3dc60c8514eb56f8d816d8f288286eb04e0465b21913b7c9e00d46dec06438e72432147b9d5adef84db1e51f4dca81380fb6c8544eef07b02200eef5d0f838e30147294c3478fc236471451f7e90460bead90c81d014c00eadf9f08838e30187404d5be7d136c734411355f27004b6c8544ee08600290fe33c0b7bb60d8516328e808d8bd8e6fff53dc2cd109c04a5b21913b82980088faedf361d8516330eca891da77ef856d8d28c256ea0460b5ad90c81d014d00ea5eeac177018a84c28e6c76af37751bbae0b646145dab7502b0de5648e48ea02600a27ec7c330f0a8211878d440ed96fb611b238ab8f53a0178d55648e48e002700752ff5e2bb004540814716e9dffebbe23646146dafea04e06d5b21913b2eed8e43dfead68ef8b52ea8ff70120c3d3a06861e1d55fbce38d8b68862e06d9d00bc672b242acfea94a91bdb1907be5d1f716f3bbc9db2a54cfda7cfc0e0a32350e8d111b51f3e986e43b86d1145de7b3a01d8662b242add2a19308b79ebdfee168fde0958dfc11cfeea1d187ec409404e3b56a61798826d8a281eb6e904608fad90a874d715f99b3f72bf47ef04bc36949f07c801865fd2e977fe5fee87db12517cecd109c017b642a2d26880a3602f96fe39605125de76b95e1bc6770200188049b66385a9fbd700dc8688e2e50b9d007c632b24726e4dcad40de98983dd89319df1f6ddb0aeada9dfb518066152c1104ca8daf71fe05aff9424dfe804e0a0ad90c8b9aa3638d09dd2770196b6c0fb7049fde69bcce12fdf8481983428081367fb7253fbc628d8568862eca04e000edb0a899c2be62b7fc51ae7dd57031bd8d84d2603379afa9d8f9ac307b6c1808c3b188871b7f33953fbde1409fd2b4ddd7a0fdf71220ab7c39c0050f9e69f8b83bc54fd7a99baa79be37d7965d358189071070332e6f8377ea2b4f404807f02a0f28ced8483bc1c93fdff0a56fdfe8f6048c6190ac858dbb6045e7ba2044aff09801f02a4f20c77f1edffac7ff8f46700abed0b6148c6190cc918ab7d6b0cbef644c993fe1020bf0648a55b23ceef8543bc1c2303b8fffa86aee6f0b77b6050c6150ac9d8dafd223fe54f744cfa6b80bc111095ee899638c0cb35b027de9fc7eaf7be0c8332ae6050c654ed96c9f09a132554fa4640bc1530956e96fc468502dc0d2b7dfe20a04ad887015150c655ddcbfdf135274aa6f4ad80b9181095eeaef638bcddb0e05cbc4f8f25e9c38028286369db13f05a1325587a31202e074ca5d30feba1f076c38c80fe5ebbfd1118967104c33286f8e13fa246d2cb01bf6a2b242ade2d1e7c05306b7a1bbc4faf25e8c380282c63871ffe23425ed509c07a5b2151f16ef67002f04040130051bff72518987eabffe40353b3f431cf543f3ecf3335ef3f8f03d967b55b26c16b4c9470eb7502b0da564854bc9b3c9c004c0b703df6907c18b0fecbeda67aea9468dab61606b2dff8e13f2268b54e0056da0a898a77a387138029014e0044583e0c58336f0e0ed8309b3b0386b1eff8e13fa25c56ea046089ad90a878633be3f0764300b7036e20241f06acdbb006876c88d5ac5e8c03d967fcf01f514e4b740230df5648543c2fff0410f03b0061f93060fdde8f4cf503d360d086d203534dcdd6176020fb8a1ffe23ca67be4e00eeb3151215eff60e38bcdd3027f8c13b2c1f06ac5bb70a876d08d5ac7a1c07b2cff8e13fa2bceed309c08db642a2e2dddf0e87b71b1eadc4fbf4d3a61b6020fbeec06e5333ff4118b8a1326fa6a9d9b50106b2dff8e13fa2bc6ed409c0705b2151f1667a782be0275be07dfa2c2c1f06acdfb5c5d4cc9a8183370c663e60aadf5d0dc3d877fcf01f5121c37502d0db564854bc87cfc5e1ed86d529bc4fbf6d7f18067210ea3f79dfd4cc9d8d03384873a69b9af7d7e0300e40ed5bd7e26b494459bd750250692b242ade52f92d1d8577b9025a0d100ad99d01ebf76e35350be6e1200ec2bc59e1f8d05f163ffc47548c4a9d009c652b242ade73f25b3a0af0725dd21def2f2061f930e05107769bbad7d69b9ad9337128fb615695a959b7d4d4ec92e340411c107ef88fa82867e904a099ad90c899febd708897637457bcafa084e5c380765fef30751b569beae95538a4bd307d9aa959fdb8a9d9b10e0670d0f8e13fa2a234d309c089b64222672eea8143bc1c7a8741b4af00d5efdf8a433804eabf9289c0bbaf99da552b4ccd831edc3970ce0c53bd62a1a97e7585a9de1ecee04ffb981ffe232ad289ff638cd149c021db0f888a77a5fcb68e42bc1c7a7f01b4af2085e8c38085e82242fa2782da154b4dcde2474df5230f999a3933d337e98101afa6c9cf665599eaf9b34cf5a30f9a9aa50b8ebcc51f92457d8ac10fff1115e590667f7602f0a9ed8744c5bbc183db01ebfd05d0be82b4a14b3c9609fe7aa7a9ffec4353bfe3dfa67af32a53f3a1047c48dfce77841ffe232ad6a7d609c066db0f898af74f0fee06a8f71740fb0a58e83e0c582618a411c50fff11156db37502f0a2ed8744c5bbd783bb01eafd05d0be82b6e97a18a451858234aaf8e13fa2a2bd689d002cb4fd90a878556d70889763694bbcaf1008f387019d42411a49fcf01f91130bad1380db6d3f242adebc5638c4cbf16c48ee028844e8c38085c0308d207ef88fc891dbad138061b61f1215efb14a1ce2a5eadb0bef272ce2f2614081c23472f8e13f22a786592700ad6c3f242ade532edf0ef8821e783f2112970f03c2408d187ef88fc8b156d609c099b61f12156f8dcbb703beac1bde4f98c4e4c3802850a3a6eee57ef81a11512e675a27004dc58f961f123933a0270ef3525cd305ef2364e2f0614014a891f2f162786d882827cdfaa64727009949006f0644a5bba83b0ef352dc12bedb004331f830200cd508e187ff881c4bdf04c83e01d8687b1251f146ba783be00921bc0d3012830f03a2508d0c7ef88fa8141bd1046081ed4944c5bbcec5db014f6a8bf71142f57b37c2608d0a18ac1151bbe57e784d8828af05680230def624a2e28deb88c3bc1421bd0d3014f10f03a2608d0a7ef88fa824e3d10460a8ed4944c5bbab3d0ef3522c08e96d807388f2870151b046023ffc4754aaa16802d0c2f624a2e2e9bd0034b8ddf05c88ef0208d4bc37d3d47ff5210cd8b083e11a763b9e3135af8d86d782880a6a812600bfb33d89888a50f3fe5c53b3eb4553fbd96b3064c30c066c88557ff88839b86986a97ef52a782d88a8a0dfa109401371c8f224222a427a02900ea80da666e76a18b461650fd830abfef703e687cdf3c47c4e00884aa319dfa4d10420330978d3f244222ac2b1094026a8b63f630e7fb313066ed8588f3bb476bd680e6dba2f1dfc599c001095e44d6be6db2700736d4f26a202ec130055bd738da9dbf72e0cdd30b11f77d8547fbcdc1cdc34b541f873024054b2b9d6ccb74f00aeb43d99880a401380b4ddeb4ced271b60f086053ceeb0907afde19dd98dc29f1300a2925d69cd7cfb04a0d2f664222a20e704206bfbb3307cc3001e6fe03698ea772649d03fd428f8b33801202a49a535f3ed1380d36c4f26a2020a4e0044b54c02eaf77f04433848e85803b5739539f8f6fd30f4ad3801202ac969d6cc6f300150f284bdb61710511ec54c00d276bd60ea3e7f13067150e07106a47aeb63e6e0a62a18f8769c001039b6d79ef70dfea1e449ab6c2f22a23c8a9e00a8dd1bc40b308c83008f3100d55ba69b1fde7910863dc209009163abec79dfe01f4a9e34d1f62222cac3d104204bbf2af8ed2e18ca7e82c7e6a7dd6bcda14d85dff2b7e30480c8b189f6bc6ff00f254f1a687b1111e551d2044054ef586deabf7a1f06b35fd071f966fb0a73f0edc930e00be10480c8b181f6bc6ff00f254f3acbf62222caa3d40940daaeb5a6f6d37fc170f6033c261f547f30df1cdc3413867b3138012072ec2c7bde37f88792273515f5961711511e654d00d236989a1dcfc180f61a3e1e6f556fd61bfb1cb9a56fa9380120724433bda93def1bfc234b9eb8c5f24222caa3fc09c011e95b08efdf0e83da2be8383cb3f37973e8ed86b7f42d152700448e6c4159dfa840c99367d95e4c4439b83501489390acfbe21d18d65e80c7e081ea8f9698839ba6c1302f052700448ecc4259dfa840c99307d95e4c4439b83a0150bbd79bdaddeb6060bb0deedf65d55b669b1fde990383bc549c0010393208657da302254f3ed3f66222cac1f5094096fe49e0bb3d8d42db4d70bfae596f0ebde3fc2b7ec5e00480c8913351d6372ac892177c6edb001101d55b1782f07347f58e55a6feebad30bcdd80f6e90abda5ef265dbf1f0778b90ebe351e5e0b226ae47394f10a162a79d112db4688c8a266d3f5a6e6bf9f19f3d34fe6c71ff699dabd6fe2302c53f5aeb5a6eecbf76080970bedaf5c07776d34ffddb2180677b90e7db8dcd41fd891ae73ad7bbd06e8da10d1514b50c62b58a8e445a36c1b21227134f8c1c3ab8940f5ae759e7c3810edab1c3fecda60fefbee6330bccb7134f8cd4f472adaf2e0448028af51d24d60cec342252ffaab6d234489962ff8ed8f231381b76048966e8339b4739d39bcff6318e6a5c0fb71ae7af746f3edd65512d60b1a8577390e7df8a404ff4ea9d1c6c16f7f70224004fd55ba07cc7958a8e445c78b83968d10259293e0b73f3c9908ec5e6f0eed5a676a3fdf0443dd09b87d07bedfb9c17cfbd16af3fdbb8b608097ca49f0db1f9c08101da5197ebc740b98f3b0304b5eb8d6b221a2c4a879beb959f7605ff3eeeb4f4b5728fff1e3c12f3d7847e0c89f060eed5c7bc42e9d1838f3dd476b1c5a6dbefdf059f3ddfb4f79f356ff5609fe6f4a0b7efb43af9d5e43bd96e81a1325c05ae90a30df152ccc9217df6adb18516c69506c79a2af7968ea583373e64cf3e0bc87cc94c9f799c3870f4b7770e7e1d544a054288483e066f0eb43af995e3bbd867a2df59aeab5e5648012e656e90e30df152ccc9217b7b56d8c2856341076aee86b9e983dd6cc9e7d24f4ed1e59305bba83bb8fb04c045018fbe948f0ef921a7127f8b30fbd66e85aea35d66badd79c93014a80b6d21d60be2b5898252f3e45fc68d91851e4e9c0bffbe9bee6b987c79ab97370e85bcd9c35dbecd9ad21e5fe23e889000a653f7815fcfad06ba5d70c5d4b2bbdf6da06b42d70324031a4d97d8a740998ef0a165ac9065eb76c902892b2a1bfeeb1b1e6a1070b87bedd944913a53b78f7086a2280c2d94b5e067ff6a1d70a5dc37cb44d68dbe0648062e475e90e30d7b360a1956c64bc6da34491900dfd0d8bc79a05f39c87beddd32b964a97f0f6e1f7440085b4170e6d7dcaf3e0d7875e2374ed9cd0b6a26d8693018ab8f1d22560ae67c1422bd9c8df6c1b250a2d6be83ff250f9a16f55555565befdf61be916de3ffc9a08a0b076935fc1af0fbd367a8dd0b52b95b6214e0628a2fe26dd02e67a162cb4928d3411fb2d1b250a9506a13fdfddd0b7ab9a76af740bff1e4726026fc3f076030a6d371c0b7eff1e7a6dd035738bb62d4e06282234b39b48b780b99e050bed64438b2c1b260a9c9fa16f35f7c179e6957fbd24ddc2dfc78f07bff2642280c2bb1c47827f77e6a8fd7be835d16b83ae99173819a0905b24dd02e6b9152cb4938d0db66d9cc8774185beddd429934c7d7dbd740dff1f6e4f0450889722a8e0d7875e0bbd26e85af98193010aa1c1d235609e5bc1423bd9d8e9e227cbc6897c1196d0b79b37e701e91ac13ddc9a08a03077e2d0d615a6fedb60823ffbd06b81ae51103819a010d0ac3e5dba06cc732b5888c80637597640e499b086bed5ec3973cd475b3f90ae11eca3dc89000af5628421f8f5a1d740af05ba4641e3648002b249ba06cc713b5888c84627d87642e49a2884bedde449f748d708c7a3d489000af77cc212fcd9875e03746dc2869301f2d104e91a30c7ed6021221b4dd9764254962886bedd92c58f48f708cfc3e94400853c7224f8f764f6128e87d63dba2661c7c900792c25dd03e6b81d2c4464a3ba3cf077969d10956cdb8ac1910d7dab1933669a7dfbbe902e12ae477a22f079e189000a7bab431f852ff8f5a175ae758fae4994681fd0be80fa08510934a3732eff6b070b73910d2fb5ec88a864b52f3437eb1ebf090e8a51336d7278fe14607ffc78f0ebbc130114fa4a83ff7008833ffbd03a47d7226ab40f685f407d84a8047abb5298df082ccc4536ceaf0352d97e5855619ebb3f65460e4a99ebaebb1e0e8c51f3e20baba48b84f7916b2210b5e0d787d635ba0651a36d5ffb80f605ed13a8af103954d4d7ffb260612eb2f15f895acbce888af6c12315e6deab53a6439be626953a66f4e8abe0001925d3a64d35070f1e946e12eec78f871a4e048e05ff4a09fe4f32cf0aef43eb58eb1a5d8328d1366fed03da27b46f681f417d87a8089acdbf926e02f31b8185f9c80e5658764894d781a72bcc923b53e682f31a86bedd65975d0e07ca28993d7db27491683cb21381a8047ff6a1758cea3e4ab4ada33e90a57d45fb8cf61dd4a7887258215d04e6762eb0301fd9497fdb4e891aa8156fcc4999f197a54cab4a3cc821175f7c091c30a362cedc07cde6cd6f4b3789c6a376f913e69b79f767fe15fe87d6add631aafba8d0368eda3ea27d47fb90f625ed53a8af1159f4976e02733b1758988fece497a2dab253a2b4bdcb2bcc43e352e6fcae78402bc690a117447a909f32f93e73f8f061e92ae17ed42e5f62eaceeb6d76fde97f65123029531ade87d6a9d62daaf328d036ad6d1bb5f962689fd2bea57d0cf53d4a3ccde45f4a5781b99d0b2c2c4476b4ccb2634ab0436b2accda692973ed8529d3a2391ebc9c1a30606068efee568c850fcf916e12de47ed934bd3e19f9e00fcefff466212a0758aea3a0ab42d6b9b466ddd29ed63dad7b4cf69df437d92126999741398d7f9c0c24264677d6c3ba784d9f1588599767dca746d8f07aa72f5e973be99353b9a83fecc59b3cd9e3de1fc247ded53cb8e86ffd10940c827015a975aa7a8aec34edbb0b665d4c6cba57d4ffba0f645d4472951fa485781799d0f2c2c447676923868d93925c0f7ab2acc8a7b52e6d2fe7840725bcf9ebdcc8c99b3e0c01a7653264d94ae12ae47ed8ae50dc2bfc10420c49300ad4b54c761a76d57db306adb6ed33ea97d53fb28eabb146b9ac527495781799d0f2c2c86ec70b1e50028c66a9eaf304f4e4c99ee1df1e0e3a5ae5dbb9907aaa6c30136ec9e59a9efca85e351bbf2c946e1df68029099047cfb5078becda07588ea36ecb4cd6adb456dda4bda47b5af6a9f457d996269b1741598d385c0c262c84e7bda0e8262684355ca0cec89071bbf74ead4d94c9d169e255f8b55555565befdf61be92ec13e7285bf6a3401383a0998927975700fad3bad4354b761a66d55db2c6acb7ed13eab7d17f5698a9d9ed25d604e17020b8b213b3d517c6f39088a912f9faa30570e4ec1c12508eddb773093264f81036e984d9f76af7497e01eb5cfac80c19f0527002a049300ad3b54a761a66d54db2a6ac341d03eac7d19f5718a05cde013a5bbc09c2e0416164b76fca8e5402826de7fb8c2f4ec84079420b569d3d6dc736fb4be0a36f7c179e6957fbd24ddc5ff47a1f05730fcb3029c04689d69dda13a0d2b6d9bda4651db0d92f665edd3a8af53e43d2add05e673316061b164e7ed6c074311b77a72cab47670f31ebfb56ad5dadc75d7dd70000eaba9532699fafa7ae932fe3d6a9f5d0903df0e06bf55009300ad2bad33549761a56d52db266ab361a07d5afb36eaf31469eda4cbc07c2e062c2c96ecbc89d86339188ab079ff08cf5bfef954569e6b6ebb7d021c88c3eaa1390f4897f1e751fbdcd330ec1118fa76e949c0d4ccd6bd7f685da13a0c2b6d8bda26515b0d1bede3a8ef532469f636912e03f3b918b0d00939805b2c074411b5f2de68847f56cb969566dcf85be1801c467a33988f3ffa50ba8cb78fda55cfc0a0cf05063ee2d32440eb284a3781d236a86d11b5d1b0d2be8ec6008a9c5ba4cbc05c2e162c74420ea299386c39288a98b7e65698ca9678b008b3162d5a9a1b6fba190ecc613465d23dd265bc7bd4ae7e16867c3e30ec73f16112a07584ea2e8cb4ed691b446d33ccb4af6b9f4763014586666e33e93230978b050b9d9203596939308a905d8b2b4ca7b678a0888a31d75d0f07e8305abaf811e932ee3f6ad6ac81015f080cfa7cfef427f3d5a24599bdbafbd0ba41751646dae6505b8c0aedf3daf7d1984091b052ba0ccc632760a15372305d6c074711a0f7120ffa3bfe6e1935fa2a385087cd8c1933cdbe7d5f48b771eff1dfefbf37fbaf1c0903be1018f205ecbee51fe97dbaf9d03ad1ba41751636dad6501b8c1aedfb5c4f20b2ba48b78179ec042c744a0ee638f199e5e028021ebd2d5a7ff72f44d759470376d84c9becde9f0234883ff9cf6769fb473a9f04a080cf67f7cd371fdd9f9b9300ad1354576153682dffa8d131008d0d146a9ab5c749b78179ec042c2c851cd06d9603a490fb6a458569df1a0f0a51a6ebada3813b6cd6beb04aba4d798fff7effc3d130ce723a0940219f8b35fcb3f418ca7d685da03a0a1b276bf947858e013a16a0318242eb36e93630879d8285a590833a43fc6439480ab1bb47c7ebb77f2b5d775dd75f478378584c9b36d51c3c7850ba4e690f14fe59fbafb802863d82821e41e19f55ce2440eb40eb02d5515894bb967fd8e95880c6080a25cdd833a4ebc01c760a16964a0e6c8de54029a43e7eb4c2b5b5fbc34ad75f0ffbd7c9664f2f6dd19deff3847fd6fe2b2e87816f87c2de2e5ff867e93195f2d03a407513166eaee51f563a16e89880c60a0a9d35d26d60fe960216964a0eae97ed602984eeb92abebffd5be93aecba1e3b1ad8c3407fb3dcbcf96de93ac53fbeffa170f8671db8bcf0240005be5531e19fa5c7e6e4a1e71ee6776abc5ccb3f6c744c406305854e2fe93a307f4b010b4b2507f773b1cf72b01432875647ff6b7f4ee87aecba2e3b1ae0c360cae4fbcc4f3ffd24dda7f0c349f8671db8ec3218fc5928f4b39c847f56b193003d673d77542761e0e75afe61a063828e0d68cca0d0d06cfdb9741f98bfa58085e59003e49d01436cddb464fcf66fa5ebb2ebfaec68a00f83850fcf91ae93ff514af867e59b04a0e057a5847f563193003d6754176110d45afe41d3b1018d19141a65dff9cf0e1696430ef23471c872d01422632f49de0440e9faecba4e3b1af0833673d66cf3c99e3dd27df0a39cf0cffafefc3e454f00760f1800b7e144be49809eab9e33aa8ba085612dffa0e8d880c60c0a05cdd4d3a4fbc0dc2d152c2c971ce874cb815348ec7fbac29c1bc15bfeba45d769d7f5dad1c01fb42993264ad769fcf8fe878330609daaeed5b3e809c0aeca4ab80da7f4d8d143cf15d541d0c2b696bfdf746cd031028d1d14b8e9d27560de960316964b0ef6f7e247cbc153082cbb2b99bffd5be97aedba6e3b0a80a03dbb72b9749f638f1f5c0affbdcfe45e23004e00c427afbf0eb7e5949e83f5a1e788ce3d68615dcbdf6f3a46a0b18302a559fa7be93e306fcb010bdd2007bcdc7202140297f6c79d3e6974dd765dbf1d054190aaaaaaccb7df7e23ddc7bdf0575fdf70030c7f85c25fed79a00a6eab14d949809e9b9e233af720857d2d7f3fe91881c60e0a94fe660073b65cb0d00d72d0e7d84e8202b4e7890ad8e1934ad76fd775dc51200469fab47bcd0f07dd0b7ff5dfbe7d61f82b14fe6af78517c26d954acf49cf0d9d7390a2b496bf5f74ac40630805e61c94b16e80856e91037fcd762214903937f3ed7f3b5dc75dd77347c11094b90fce33cf3ff3080cd1527cba63a7a9eddd0b86bf42e19ff6d7bf9a4f76ef81db2c859e939e1b3ae7a044712d7f3fe85881c6100ac46b285bdd020bdd2207cf1b038544df6eb8b3279daee7aeebbaa38008cad429f79b9dbb76c22075eaf3b97361f067c1f0cfd8f3dc73709b4ee9b9e839a1730d4a54d7f2f7838e15680ca140b87ae31f3b58e81639785d2570a7e56428009b1fe2dbff85e8faee28288232e781db61983a75e0b21130f8b350f067edfee76d709b4ee9b9a0730c4ad4d7f2f7838e19682c215f6976bab2ea5f2eb0d04d720257584e8802303121b7fe2d97aef38e0223087a0ffad75e5e0503d5898379defe5728f8b37677ef0eb7e9849e4398d66488cb5afe5ed331038d25e4ab2b50a6ba0916ba494ee22471c07252e423bdbd67c704ddfab75cbade3b0a8e204cbeff2e18aac5facfeb6fc0d0b742c17fd49ffe643ef9e003b8ed62e939a0730b42dcd6f2f7928e19bc3570a034334f4299ea2658e8363911de1e382049bcf56fb974dd77142041786cdebd30588bf1e59d77c2d0b782c16fb167e142b8ed62e8b1a3730a421cd7f2f71a6f0d1c28d76ffb8bc042b7c9c99c22f65b4e8e7c92d45bff964bd77f0fc34a75d367cc30effdfb0d18b0857c3b64300c7d2b14fa56bb475f05b75d881eb31e3b3a273fc57d2d7f2ff1d6c081d1ac3c0565a9db60a117e484aeb39c20f9406feb5999e05bff96abff8081a1f8fbf5d4fb4afb305eaedbff5aa1d06fa0790bb8ed42f498d1b9f849af9d5e43746da9301d3b786be0405c8732d40bb0d00b7252fa59002e15eca3a5bcf56fd9743d785d171e058c9f9e593a07066d2e9f3df5240c7c3b18fa367bfef50adc472e7aace81cfc94a4b5fcbda463081a5bc8339a919effed3f0b167a454e6cb4e544c963bcf5af3b745d785d1f1e058d5fa64d9b62b66fff08062ef2f5983130f0ed50e0dbed993205ee03d163d46345e7e097a4ade5ef25de1ad877a351767a05167a454eee04f199e564c923bb79eb5f57e9faf0ba4e3c0a1cbfcc9c52fc9f02be3fff7c18f87628f0ed760f1e02f781e831a263f74b52d7f2f7928e25688c21d769369e80b2d32bb0d04b7282232c274c1ee1ad7fdda7ebc4eb7af12878fca01f687be985e53078ad3efd785bdedbff5aa1c06fe4ecbf984f76ee82fbb2d2630bf28393495ecbdf4bbc35b06f46a0ccf4122cf4929c6453b1c772d2e481f3bbe2ce4ce5d1f5e275dd7814407e9832e91eb3e7d34f6100677d3163060c7b04063eb067e5d3705f597a4c7a6ce898fd90f4b5fcbda463091a63c8559a894d51667a09167a4d4e7498e5c4c965bcf5afb774dd785d3f1e05911f16ccba138670d681e1c361d82328ec91dde3c6c17d65e931a163f503d7f2f71e6f0decb961282bbd060bbd26277bbcd86e397972d1c4d17cfbdf6bba7ebcae238f02c96b3367cd329bded80083581dec55dcdbff0a853db2bb7367b82fa5c7a2c7848ed56b5ccbdf1f3aa6a0b1865ca159783cca4aafc1423fc8090fb45400b984b7fef58fae23afebc9a360f2da94fb26c030fecf2bafc2a0cf05857d2e9f6c790fee538f051da3d7b896bf7f786b604f0d4419e90758e80739e92662b3a512c8056b79eb5f5fe97af2baae3c0a28af2d7b745aa330fef2b6db60d0e782823e973d0fcd6fb43f3d06746c5ee35afefed3b1058d395416cdc0262823fd000bfd2227dec25211e482b1177302e0375d575ed7974741e5a5aaaa2ab3f5c37f3708e4ef060d84419f0b0afa5c768f1cd9605f5b3fdc923e06746c5ee25afec1d0b1058d39549616281bfd020bfd2415b0d4562154a2fd2b79ebdf20e93af328b0bc5435e99fc742f9934f4d4d11b7ffb542419fd339e7984f3efdcfd1fde9bed13179896bf907277d6b601963d0d84325598a32d14fb0d04f520967881a4ba5508978ebdfe0e97af328b8bc32f7c179e6f9671e4907f2de254b60c8e703833e8f3d1b36a6f7a5fbd47da363f20ad7f20f1e6f0dec1acdbc335026fa0916fa4d2a6282a562a844bcf56f38e8baf328c0bc3275cafd66e7ae9d66ffd557c390cf07857c3e7bee3bb22fdd273a16af702dff70e0ad815d330165a1df60a1dfa4324e169f5b2a871ce2ad7fc345d79f4741e695b90fdc6ebeefd307867c3e28e4f3d93d60407a5fe818bcc2b5fcc385b7062e9b66ddc9280bfd060b83201532c45241e4106ffd1b3eba0ebd5fb7c6d5a56f3f947046219f0f0af97c5e6ed9d2b72592b9967f38f1d6c0651b82323008b0300852293f136f5a2a891ce0ad7fc349d7a3f72b30a74cb803867c3e28e4f399f44f7f16fbe15afee1c55b03974533ee67280383000b832215f3774b455191de99c7b7ffc34cd7a59f396b360c3ab72d1b71190cfa5c50c8e7f270df7e709f6ed3bae25afee1a6630e1a8ba8a0bfa3ec0b0a2c0c9254d0225b855101bcf56ff8e9faf4ba4e3d0a3c374d9f3ec37cdeb7b8a580150a7a64f35fff9ade36daa79bb8967f34f0d6c0255984322f48b030485249bf15072d954679a46ffddb0677520a175da75ed7ab47c1e7a6076eb905863d82c21e99ecc33d0eb8967f74e898c35b033ba299f65b947941828541938abac6527194c7daa9fced3f4a74bd7a5db71e05a09bd60d1b0603df0e85bddd939d3bc37db8896bf9478f8e3d684c22e81a94754183854193ca3a4ebc65a93ccae106defa377274dd7a5dbf1e05a15ba6c9f6bfeb731e0c7d2b14f8565bffefff3553274d86fb700bd7f28f261d7bd098448d68961d87b22e68b0300ca4c2fe2cea331548006ffd1b5dba7ebdae638f02d12d73c68c81a16f8542dfea018f6f6ac4b5fca38bb7062e8a66d89f51c685012c0c0ba9b83b2d1549364befe46fff51a6ebd8eb7af62818dda0dfa3df3c78100cfe2c14fa596b2b2b3dbd8f01d7f28f3e1d83d0d84447dd89b22d2c60615848e59d203eb65426590cef873b254587ae67afebdaa38074c394bb279a5a10fc5928f8d54e31f9cebbe036ddc0b5fce341c7203436519a66d70928dbc20216868954a02e19fc53a6422963d7627ef73f2e745d7b5ddf1e05a51b168d1c09c35fa1f05773070f81db7203d7f28f171d8bd01895709a59812ef55b0c5818365291b32d154b82b7fe8d175ddf5ed7b9478159ae993367993dfdfb173d0178e3fffdbff46bd0b6cac5b5fce387b7068666a32c0b1b5818365299a78abd96ca4dbc3ebcf56f2ce97af72838cb35f5d67f163d019874f32d701be5e25afef1a463111aa3124cb3ea54946561030bc3482ab487a582138db7fe8d375df71e0568b99ebde492821380c77bf484af2d17d7f28f37de1ab8811e28c3c20816869554ec325b4527d2ddbcf56fece9faf72848cbf1c0b407ccfef31bde26d81afeef9d7d76fa39e8b5e5e05afef1a763121aab126819caaeb082856125957bbaf8ca52d989c35bff2687ae838f02b51c336e189b730230e5aaabe16bcac1b5fc9381b7064ed36c3a1d655758c1c230930aee62a9f0c4e1ad7f9345d7c377f3bbf8731f9c675e1b3ab4d104e0b9b66dd33f43af2905d7f24f1ede1ab8a20bcaac3083856127153dc356f189c15bff268fae8bafebe3a3a02dc5d4fbee378732b709d6f0dff67ffe8f9972efbdf0b9a5e05afec994f05b03cf40591576b030eca4b27f21b65a2a3f11bee6ad7f134bd7c7d775f251e09662fe55571d9d00ccbce862f89c52702dffe4d2b149c7283476c59c66d12f5056851d2c8c02a9f0b3455de60224c212defa37d1749d7c5d2f1f05af53b367cf311f0d1c605eaea830b3e4ffd1739ce25afea463141abb624c33e86c945151000ba3422a7e8ce542c4de554353a67debe69460e7f7ee66a64e9d96be514fb9a68e1f6f26dd7c33fc99537a4c7a6ce8982939748c4263578c8d41d91415b0302aa4f29b88b5968b414444e407cd9e26289ba2021646895c8066e240e682101111794d33a719caa4288185512317a2b7e5c210111179a937caa2a88185512417649eed02111111b96d1ecaa0288285512417e564f181e522111111b94933e664944151040ba34a2ecc1fc477990b454444e416cd963fa0ec892a5818657281ba899f32178c8888a85c9a29dd50e644192c8c3ab950132c178e8888a81c1350d6441d2c8c3ab9587a7f80d5968b474444540acd92487fdf3f1758180772c17e2d76672e20111191539a21bf46191307b0302ee4c2e97a01d5990b494444542ccd8ec8dee7bf18b0304ee4020eb15c502222a2620c41991227b0306ee44256d92e2c1111512e55284be20616c68d5ccca6e215cbc525222242342b9aa22c891b58184772417f2376652e301111919d66c46f5086c4112c8c2bb9b07f14df642e341111519666c31f5176c4152c8c33b9c02d455de6821311116926b444991167b030eee4420fb25c7822224ab641282be20e1626815cf071b606404444c9330e654412c0c2a4900bbfc0d6108888283916a06c480a58981472f1f5eb81eb2c8d8188889241c7fe447cdd2f17589824d2004e151f641a041111c59f8ef9a7a24c4812589834d210ce10fb320d838888e24bc7fa335016240d2c4c2269107f11df651a081111c58f8ef17f41199044b030a9a4619c230e661a0a1111c5878eede7a0b13fa96061924903692d6a320d868888a24fc7f4d668cc4f32589874d250ba8afa4cc32122a2e8d2b1bc2b1aeb930e16527a12d057fc9869404444143d3a86f745633c71029097349c61e2a74c432222a2e8d0b17b181adbe9085848c748031a6569504444140da3d0984ec7c0426a481ad24db686454444e175131acba92158488d4983bacbd6c08888287cee42633835060b09d386656b684444141e0c7f076021e5260d8c7f0e20220a1fbeedef102ca4fca4a1e90703f9ed0022a2e0e958cc0ffc9500165261d2e0f42b82bc4f00115170740ce657fd4a040ba938d2f0f46641bc63201191ff74ece54d7eca000ba978d200f5b6c15c3b8088c83f3ae6f2f6be658285e48c34445d4088ab081211794fc75a2eece3025848ce4983d4a58475ad69d4608988a87c3ac672495f97c0422a8d34ccbf887d99864a4444eed1b1f52f68eca5d2c0422a9d34d033c40799064b4444e5d331f50c34e652e9602195471aeaa9625da6e1121151e9742c3d158db5541e5848e59306db542cc834602222724ec7d0a6688ca5f2c142728f34de7196c64c4444c51987c654720f2c247749431e24ea2c0d9b8888301d2b07a1b194dc050bc97dd2a05b8a6f320d9c88881ad331b2251a43c97db090bc210dfb8f6257a6a11311d1313a36fe118d9de40d5848de9106fe1bf14aa6c11311d19131f13768cc24efc042f2963474fd864055a6e1131125998e85fca47f006021f9431afd10519de904444449a263df103436923f6021f9473ac0d96277a643101125818e7967a33191fc030bc95fd2117e2d56673a0611519ce958f76b341692bf6021f94f3a44133141fc2450a721228a321ddb748c6b82c640f21f2ca4e048e7e826b8ac3011c5898e69ddd09847c18185142ce9287f105c519088e240c7b23fa0b18e82050b2978d2614e16f3321d8888288a740c3b198d71143c5848e1219da7b73890e94c444451a063566f34a65178c0420a17e948cdc4da4cc722220a331dab9aa1b18cc2051652f84887d26f098c115c559088c248c7261da3f829ff888085145ed2b9f4c6415b05ea80444441d0318937f689185848e1261ded176246a6e311110549c7a25fa0b18ac20d16523448a7eb22beca744222223fe9d8d3058d4d140db090a2433ae0e96259a6431211f941c79cd3d19844d1010b297aa433f6107b339d9388c80b3ac6f4406310450f2ca468928e79aa982db89e0011b949c7141d5b4e45630f45132ca468934eda427c2c504726227242c7921668aca1688385147dd2614f10778a7a813a3511513e3a76e81872021a6328fa6021c58774de3f8bb704eae04444888e197f46630ac5072ca478918e7c9cb8461c14a8b31311291d2374ac380e8d25142fb090e2493af56fc522813a3e11259b8e0dbf456307c5132ca478934efe77f166a6d31351b2e958f077345650bcc1428a3fe9f03f1343c4e7020d0a44146fdaf7750cf8191a2328fe6021258774fe93c5045123d0204144f1a27d5dfbfcc9684ca0e48085943c32189c21960a346010513c681f3f038d01943cb090924b0607bd89d0e6cc604144f1a07d9a37f3a1066021259b0c144dc440b15da0c18488a241fbb0f6e526a8af53b2c142222583c6f16298d823d0e04244e1a47d56fbeef1a86f13295848642583485331427c26d0604344e1a07d54fb6a53d49789ac60211122838aae2f305aec1368f021a260689fd4bec9fbf653d16021513e32c89c24ae13fb051a8c88c81fda07b52f9e84fa2a513eb090a81832e89c226e1107041a9c88c81bdae7b4ef9d82fa265131602191133208e93b0257881d020d5644e48e9d42fb1a7fe3a7b2c142a252c8a0a4ab0ef612af093478115169b44f69dfe22a7de41a5848542e19a8ce11cbc58f020d6844949ff61ded43e7a03e46542e5848e41619bc7e2fa68b43020d7244d490f615ed33bf477d8ac82db090c86d32989d26f4434bfc0a2111a67d43fbc869a80f11b90d1612794506b79f0bfd5be61af1934003215152681fd0bea07de2e7a8cf1079051612f941063c5d81f036c13b0c52d2689bd7b6cf95f92830b090c84f3208eab707ba8895e2b040032651d469dbd636ae6d9d9fe6a7c0c142a2a0c8c0d84ce8df41b90011c585b6656dd3cd509b270a0a2c240a9a0c96ba24713bf1a8f85ea0819528acb4cd6adbd536cca578299460215198c8007aa2e829168b83020db84441d3b6a96d54dbea89a82d1385092c240a2b1958f5b6c37dc432512dd0404ce4176d83da16b54df2f6bc1429b090280a64c0fda5e82f56885a81066822b7695bd336a76def97a86d1245012c248a1a19887f25068ba5e23b81066ea252699bd2b6a56dec57a80d12450d2c248a3219a08f172931416c12bce11039a56d46db8eb6216d4bc7a3b6461465b090284e64f03e5de86f6e8bc47e81067c226d1bda46b4ad9c8eda12519cc042a2b892815dbf5ef837315ebc2eb85a6172e9b5d736a06d41db04bfae4789020b89924206fd53445b71ab582bf835c3f8d26babd758afb55ef353509b204a0a58489454120afaf981bf8a516289f85ca030a1f0d36ba7d750afa55e53fe1d9fc8021612d131121c678a416296d822ea050a1c0a8e5e13bd367a8df45a9d89ae25111d030b8928370997a6e22c31504c14abc45e818289dca775ad75ae75afd740af455374ad882837584844ce49089d262ac59562ae78531c1228c4a830ad3bad43ad4bad53addbd350dd139173b09088dc2181a5df3af89d6821860afdc4f902b1517c2a92fc2d043d77ad03ad0bad13ad1bad23ad2bad337e2a9fc843b09088fc2121a77f4ed0cf18b412c3c4ed62a178516c161a90517c17418f598f5dcf41cf45cf49cf4dcf51cf55cf996fdb130508161251b84858ea8a88cd84febd5bdf0aef2d868b1bc57d62bed04fbcaf14abc57af1aa785bbc27b6095d97fe0bf18dd0afc41dced0ffd732fd993e479fabafd1d7ea36745bba4dddb6ee43f7a5fbd47deb31e8b1e831e9b1e93172253ca2d033fff3ff010e7c696c797ff1b20000000049454e44ae426082);
INSERT INTO `timages` (`ID`, `EmployeeID`, `ProfilePicture`) VALUES
(12, '11323', 0x89504e470d0a1a0a0000000d49484452000001000000010008060000005c72a8660000000467414d410000b18f0bfc61050000290049444154785eeddd79dc345579e6f10404511601410583208b806322a384650c881a500222226e80022a11414565738b01c7046312d4c1510411c880a0801a9720a21351c495b88119f715351a11354e1c63c6fcaed0a5f5deef55cfd34b7577559dfb8fefe703e73d5575ce5da79faeaeb3fdd6af7ef5ab9452a16c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b08929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b089691876d876bbdfc646d80a3b63773c0487e0283c6344ffad34fd9bf228af8ed1b1bfedce9d86c126a67ee0c3b919f6c631380b6fc3e7f06dfc04ff1fbf9a91cea173e99c3ab7aea16be99abaf666ae6ca91f6c62ea163e643be0609c8cf3f1417c1fee03bb0c2a8bcaa4b2a98c2aeb0eae2ea95b6c625a2e3e3cdbe369b814df81fbd0f581caae3aa82edbbbbaa6e5b28969b1f8706c83a37111be01f7611a02d54d75545db771b1488b6513d37cd1f837c0e1d023f397e13e2cd3f825be84ebf02e5c86f3f0d73803cfc37178020ec2be23fa6fa5e9df94e74fa16374accea173e99c3ab7aee1ae3d0dd55d31502c3670b14af3651353fb68e07a23bfcfa8c1df06f78118d70ff061bc11a7e350ec8af5ddb5dba46b8caea56beada2a83caa232b9b28e4b31516c14a3ec7958109b98da4363de1167e2ab700d7f355fc305780af4d67d73779d2e50d946655459556695ddd569358a9562b6a3bb4e6a8f4d4cb3a1e1aa7bee78dc00d7c05752bd387b2aeeedcedf27d4613be80fc225b805aece2b510c15cbec6e9c039b98a64323dd1357e0e7708dd9f921aec289d8d59d7748a8a3061969f091e234c9cf06c554c7ece9ce9ba66313d3646894fbe15ab886eb68608d1e911f8c627fefaaeef8034cfa5e44b1decf9d334dc626a6f1d0080fc4f5a346b99a7fc73538027772e72b996202f5445c8d717b1a14fb03ddf9d2786c626a4683d3b7d661b811ae514637e1346cedce97d646ac340fe15468e8b18b69a47ba17b92bd0713b289696d34ae7571246e866b84753fc6abf14077ae343e62f880512c155317eb3add1bdda375ddb9d2da6c625a130d6a7f7c01aed1d5fd335e8c4ddd79d2f488e95df0228cf3e250f76a7f779eb4269b986e4723da1a978f1ad54ad475a749301bbaf3a4f628c6782ec6e952d4bdcb9f5e2bb089a5a3d1e871ff24e86dbd6b5895af435d5a7774e749f3a398e3e9586d8095eea1ee65fe2c306c62c968287be153708da9a2474ccd87bf833b475a1cdd033c099f87bb5715ddd3bddc394a66134b44e3d030564d7e5969118defe1c958c79d232d0ff744bd33ea625d69fab4eeadee716787532f9a4d2c0d0d42dfe62bbd5c521ffe39b88b3b3e7507f76813bc0a2b8d25d0bd3ec61d5f1a9b580a1a81de2c5f396a144d3e8a07b8e3537771cfee8fd5e662e8de17fd47dd2696801bafc52fbf326a088ec6e8ff317270494fe9de41ab11a97bd6dd63511bd8dd1d5f029b3874dcf067e3ff8d1a40a4df896fc016eed8d43fdccbbb42f30d9adeefa82d3cdb1d3b743671a8b8c99be2ada39bee68d8eedeeed8d47fbab7a37beceebda86d143588cb260e1137760facb4408556b6b9b33b360d07f758938e3413d3b501511bd9c31d3b44367168b8a11a39f68bd10d8efe054f76c7a5e1e29e6b3314dd7bd726d4569eeb8e1b1a9b3814dc448d16d32212ee268b1e0707bf0847f2b8f7bbe0b3a3b6e0a8ed0c7a94a74d1c026e9cbaf83e30ba91ce85c847fec2d106f493402f085d1b11b5a1c17615dac4bee386693ef967463730fa198e76c7a572d126348df8a7a33612a92d6de58eeb3b9bd867dca89dd0f4b24ff3c5efeb8e4b89b6a1f50a9bbe38d4a67672c7f5994dec2b6e9006f734ed99f7f7c8a1bc6945b411ed88fcde519b89d4b6063568c826f61137e600343dc20dfe654e6a0f6d653dbc69d47622b5b103dc717d6413fb861ba259604ddd7caf41cede4b13a1cd6818b12615b936a5b676843bae6f6c629f7023b49e7ed310cf17bb63521a176de8f9a14d55d4e64e74c7f4894dec0b6e80bef9dd875f53419fea8e496952b4a563f16fa3b655a7b6d7eb27019bd807045ebff9dd63ffffc523dd31294d8b3675f0a86dc5f6a636d8db770236b1eb08b8def6bb177eb7e2bfb963529a95dad6a88dc576a7b6d8cbde019bd865045afdfcaeab4f7f9df3c39fe68a36a619851a4c16db9fda64efc609d8c4ae22c01ae1e706f9e8f7d9c1ee9894da465b3b68d4e6623b54dbecd588419bd845045663fb9b46691deb8e49695e68735a1cd6bd80561bedcd80339bd8350454b3fa9a26f63cdf1d93d2bcd1f64e096db1a2b6da8b816736b16b0866d394de57b9fc292d0a6df02f439bac5ce1f2778d4dec1202a9c53c5c8035543317ec6c406cd6c176f843ec87c3713a5e86a7605fe4b6593322861a3178315c1bedfca22236b12b08a096f1727dfd9aacb19e3ba654c4430df1c1f89fd0b6daff8a1837e736bc13cf8376e2cd61d3132266da9de8dd88b155dbedf4f26236b10b089c16f0746ffcf5926523774c8988853ef88fc1a71163358d1fe1ed780eb4b67e3e658d8138dd199f448ca7da7067171ab5895d40d0dceabd1a70b1b3cb5f1ae2a00ffee3a06ffb18a736697f04dd8be3b1a52b4bba1df1d91e7aa28a317cabcbdf053671d90898d6ed8f4194235dfed21007fdb67f5f2d2e8ba2beefaba12eb04d5cd94a475c1e0b17bb4eee3b60139789406998afdbb4e37c97bf24c440dffada8ebc69dd8345d23b8637637fe4cf841ae2f15ac478a94d776eb8b04d5c1602a4c13e6ebb2eaddc7a27774c29a8bfbef5df3f8ac76ad4d8d417fd2778220e81be9976c3bda08954fa8dff7a28b64dd3a9c7a53dfa5f84ec550071d0b815b7c5bcda76a70609d9c46521386ea34eadddbe8bcb5f02eaae6ffd1330ceb7feb77012267a494afe2da06e42f520acb6cffe4a340dfb1d78248aee4da0fef781bb6757bafccb62139781c0688bee182c39cae52f0175d792d557d562d1e4ebd02698ebbbf34c8af3dc1d4fc0b9f812dc3557f3093cd09dbf14d45feb55b8d874666b729bb868046473b8fdf92f70f94b40ddb5a1e56adb5bebd15d4b9ecdb55b94f3ab3bf02ce851df95a3c9bfe31c14bb182b75d746b3312e6aeb9bbbfc8b6613178d609c570b4e45bbf614f9bb9f7aab3be90ba33834f922f671c7cf13d7dc135a2b6fa52db7a3efe289ee7c4347bdf514e736243dcfe55f349bb84804622fc49750faff2277e9a5de7a4977cb280e8e7e676bfcf952ff38727dbde8d2661ad7c195d3d14bc73bb8f30d1975d61a02ae8defe5f22f924d5c1402b02edcdbd222bbfca8f766d0e625311e152d3ad1b9454f2893f6d83b1b1a34e4ca5df71e6cecce3364d4d96d3fa6b6bfaecbbf28367151a8bcde58c7a0e8d1f2ae2eff9051e70df0c1510c1c3df2efe08eed0acab7315e0d3da5b83a54346cb9a82e43eaab773aee67d3492effa2d8c445a0e25be327b540549ee6f20f1df55e6917e38f620b775c1751564d2afaf8a8ec4df4a4d38917618b427dd55313e3a0cfc0d2fe18dac445a0d297d78250d15befe2469551e7a7d66210f56a85990a65d674e467c1cde6ace80f5b312f7aa9abc674b89e9dcb5dfe45b089f34685357c3406418f8df777f9878c3adf136e0289a87fbfd78fca945fcb69af3435f9b5eeb8a1a2beea52753f91f677f9e7cd26ce1315d58b3fd7c555e4ea3ed45b73f1632c44bf17073102927a3c0c1ad1e9ea298f72c70d15f5755b8ee933b1f0178236719ea8a4ba8e62e5bf83e266975167178bcaa1ee98bea23e5a53bfe949477fec8a7929485d3781da7c8cc3c267bbdac479a182fa0de4bab906b1d1e224a8b35691d1d8fd180bb9d41dd377d44b83889ade095ced8e192aeaeb8609ebb3b1d0776036715ea8dc61b5ca5634f9a4c4177f4df3c6356a6eb06fc7a9db0b6a758df674c70c11756dfa323ccce59f179b382f54eec650597992cb3b74d4fb43210e95c35dfea1a07eea1d681aefd0d99573e681faba9f8037babcf36213e7818a1d182a2a9a5c52e2d050f593c758885e040dfe69883a6e0bb7d1a6260f15b3e41b75d50bf12f8fea5e77a0cb3f0f36711ea8d4f5a192f2749777e8a8f745210e9567bafc43445d35d5d8c5e05c977fa8a8af1b1c74bdcb3b0f36b16d5448ebd2c74a6ac24b2f764f6993ea0cd725a637e4c5ac764c5d77469c2023df71f9878afaae876fd6ea5fd9cfe56f9b4d6c1b95b936544e3abf69c23c506ff589c758c8d92eff9051e7a63110bfebf20f15f57d66a8bf5cebf2b6cd26b6898aa8eb27564e0b226ce8f20f1df57e692d0e750f76f9878c3a6b3f03178b935dfea1a2be9a08f6bd5afd2b73ef15b1896da2126e92cb8b5cde1250f74b432c448b786ee0f20f1975deb21683ba6b5cfe21a3cea78618c8dcf717b4896da1029adffef35a85e4c7287989283719e44b2e6f09a8fb3f8658c8f75cde21a3ce1b21aea7a0cfce662e7f5b6c625b28bc7693a957485eedf29682fa6ba04f8cc9fb5dde125077ad1214e321c56dff469d5f116220c7bbbc6db1896da1f0eedbaed89562a9bbdef8ba37df17b9fc25a0eeda9f20c6437673f9878c3adf2fc4406e7079db6213db40c1770c15919b5cde52507f2d101963227feef29780ba3f3ec4a2f218977fe8a8f73f8438c88e2e6f1b6c621b28f499a112729acb5b0aeaaf1d64634ce4652e7f09a8fb3e211695e35cfea1a3deee89e84c97b70d3671561458131de21af21ae659f4d651d47fc35a3ceafec2e52f0175d70e3a2e2647bbfc4347bdb5298b3661adc7429fa5b90c11b789b3a2b0eeaf7a715d3b1131d0a299312e52dc20a00a7577bf7ba5c87d0484babf3bc442e6b207844d9c1585754b201737e73f22065a0822c6455ee3f29780ba6ba110179322df01087577ef45e6b254be4d9c0505d5a8a6b8f28b563e2d7a775f2106dafdb81e97caeb5dfe125077374b541ee9f29780baeb33a4f132f578e833d5fa60319b380b0aa95d66eb059762f7f8ab230e9a0b1f7fdfc9852e7f09a87b532fc0c35dfe52507fb7a760eb6b45d8c4595048f7f85fdc38f726c4e2db2136f2772e6f09a8fb1f8758541ee2f29782faef1be221adff0cb089b3a0907181030d6f2c6ec9af26c4e263b5d8546e76794b40dd4f09b1a83cc8e52f05f5574f5a1c1afc1597771636715a14709b5060b9cae52d15f1785b888ffcd4e52d0175ffef2116959d5cfe921083ab424c645b97775a36715a14eee8505839d1e52d15f1d07efe314652dc7e8842bddd6c512d17b68ecb5f126270622d2695635dde69d9c4695138b7d4d5ae2e6fa988c70b437c2a0f70f9878e7a6bf7a3188b4fbabca5210ebb86b8c8252eefb46ce2b428dc3742618b5ade691cc4e49810a3caa35dfe21a3ce770b31a814db2b12118bb881c82d2edfb46ce23428d8f6a1a032c80d2e66414cdcbe88f21c977fc8a8b3f60d74b1286a45a095100bb7804c6b5bc6d9c4695028b7bae9535dde921193fb8618555ee9f20f19757613c6e40097bf44c4c2ed1c7d82cb3b0d9b380d0ae5fe52dddbe52d1931392ec4a8b2b42da297853aff5d8841e51e2e7f8988c5bd436ce44a97771a36711a142afe56f99acb573262a20541dc4b2f39c71d3364d4f933210695fbbafca5221e5f0bf1d166aaad8cadb18993a2303bd40a57c9e1bf01313936c4a8a24541f772c70c1975bea41683ba97b8fca5221e1784f8482b7f246de2a4288c7b99f31497b764c4a46947a0935cfea1a3de3be197b538543ee5f2978a78b82f8e56664bdac44951989343e1646f97b764c4e413214695ed5cfe125077b72af0cf5cde52118fbd427ce4852eefa46ce2a4288c9b0034d82daea7454c7e1a62244a2b76ae0475bfbc168bbae2f64968422cb4bc7e8ccfc52eefa46ce2a4284cdceef9072e5fe9888bd645a8c7493ee2f29682faff658847652b97bf54c4e39f427c5a693736715214e6fba1701f76f94a475ce2484959d84eb05d44fddd84975f603d97bf54c4e3ba5a7ce456976f5236711214c43d9ebcd1e52d1d71f9548893dce6f29682fa7f3ec4438a9d1edd84989c1762245bbabc93b08993a0107b8742c9e92e6fe9884bd3c097df71f9878e7adf01fab68ff1788bcb5f3262f2bc10239979cd049b38090ae126b71ceaf2968eb89c11e25439d0e51f3aeabd4b8843e50c97bf64c4e48f428c64e6ae769b38090a71562894e4146083b83c3cc4a972aacb3f74d4fbd1210e95c7bafc2523266eb0ddccfb49d8c4495088b8c28d0676aceff2968eb86c0ab7376091b326a977d3da0839143820265a5036eeb4fd7697771236711214e273a150c56e753d0ee2e35e7a7d0fc58d05a0ceefacc5a0923d000d884bfcac7dcee59b844d9c048588abdc5ee7f2a5db119fa625c18ada0d97fa6aa3542dfd15e370a3cb9ffe3366d784587ddbe59b844d9c048588835bdee5f2a5db119f478578555ee5f20f15f53d2ad4bf52ec4ec9ab213671ccc44f5cbe49d8c47151002d5d1c7fd35ee6f2a6db111fed0ee426c068f3d43ddd3143433db501e60f46f58e720f8906c4e6e2102bb599997e3adac47171f18d6a85a99ce7f2a6df20466f0f31ab14f1f84b3d9ba601eb5d48fefe6f406cdccfc78d5cde71d9c47171f1ad4261e4af5ddef41bc4485b62bb013032e83101d46f5bb8272079b23b26dd8ef8bc3cc44b669a336113c7c5c5770e85911cc43106e27476885be5752eff50503fb7d6bd5c8fdc416a05c4e7c5b57855767679c76513c7c5c5770f8591e7b9bc694dc4497328dc5bf099bb76ba8cfab9c93fb2bbcb9f7e83189d14623673dc6ce2b8b8f8434261e4389737ad8d58bd3fc44ef452753397bfefa897dbef4ebeeaf2a7351127b742f04c9ba8dac47171f1434261e4092e6f5a1bb17a49885de52097bfefa8d76ea19e95735dfeb426e2f4b8103739c4e51d974d1c1717777db9836cbcf340acf60bb1abbcdce5ef3beae566b4492bebdb0d1d717213828e7279c76513c7c5c59f110a23fbbabc696dc46a036845e018c38fbafc7d47bde2ca51a21e8141fee4691b71dab716b7ca335cde71d9c471e9e2a130927f002640bcdc87425adbfea90ba8cfef86fa5506f9c76e1e8855e7fe00b89f0007bbbcc9235ecf0af1ab9cedf2f715f53937d4af52dc9e88d322560785d8c9527f02b897804f74799347bcee0af73340bbbfdcd11dd337d443c39fff6554af3a7583e6e3ff9888d5136ab1ab2cf525a0eb067cbacb9b9a11b3a6bef1235dfebea11eaeff5a2e72f99347bcdcbe924bed067403818a5cdd6616c4ec91218695de4fada60eebe28bb53ad51531f9a92dc4ebb9217eb2d481406e28f04b5dded48c9869714c4d8489b1945e7f4828ff09a13e95dcfe6b42c4cc8d1b59ea50603719a8a879ed6d216ecf0f71ac7c04bd1c234fb937871bf92747b863523362e6365159ea6420371d3877059e0271bb33e216eb955e7e5828f76b433d2ada233127fe4c8898b99e94a54e07760b825ce1f2a6d5113b37ae42be853bbb63ba8af2fe1e9aa6fdeee38e492b236e9786382e774110a1007149b06b5cbeb43a62b71ebe528b65dd9fba63ba88b2ea8be103b5b2d7bdd51d935647ecde1162b9dc25c18442c445416f70f9d27888df91219e959fe13eee98aea19c2fa895bb4e8ba0ece48e49ab23767f5f8ba5746251d0b854f1575cbe341ee2a76f4f374d5814eb4eff14a07c7f88a647ff5cf07306c4efe610cf4e2c0b1e3706d1ef92418c605b16e2a765b3dc56e2f237ee982ea06cdba069b14fbdf8cbf5fea644ec349e228e18edc4c6206e6bb0fbb9bc697cc4f06921a675c7bb63968932ad8f8fd5ca58f753e4a3ff0c889fd6918c71edc4d6606e73d0c35dde3419e27875886b455b447566092dcaa29f2d6f1c95cd39d61d97c6470cdd7e129dd81cd46d0ffe6297374d8638de13b7d6e25aa79183ffc51db74894417bd65d382a93935b7db78038ba81629dd81e5c8b5bc68215b9d9e53c10cbeb426cebf47b7b695b8a716d0d61be6c541647ef83eeee8e4d93218e17d5e25ad9d2e59d844d9c1405f97e2858eeefd602e2784088aba32784df77c7cf13d7d46ffef802d879a83b3e4d8638c6f72bb7ba7c93b28993a23071551bcdfdcea19e33207e1a47af1180f5b836f931fec09d671eb896d63078cfe8daabd1f0e6addd79d2f88861ec15fa88cb37299b38290a737e289c6ce3f2a6d511bb5df18fb5588e43836cf43b711d77ceb670fe83f15db83234f914b673e74bab23767a1714637ab1cb3b299b38290a7372289ceceff2a666c44c7dbd4f47d31800893fb7223d8db5fe61e39c9b60a537fdabf91172f5df2910370dae8af17ca1cb3b299b38290aa36f8558c067b9bcc9235e07e2a65afc9c2ba15983ab7d10f507e458ccfc338c73e82dbfbaa0be0177ad8ade45dc16d21c6d8c3ad31cf6d2102fb76e642b7f4c6de2a428cc0ea17072a1cb9bd6449c346beebdb5b835792bee503b4eabc3340db9ad68251e359e8debd71c07c76c81d3f055b873d76994dff6d05382e6acc719a2d1bf415385efe6ae9dd6449c5c37eb7d5dde49d9c46950a03897fd5b2e5fba1df1b9172e80bacaea7173f4adb9d6305ad21e0e3d5abb63eaf492f095d8137789e7199d4b5d7afa43aecd27fe061a6ce4ce15e9bceb8773a9f7a26985a33a3da968cbebff5a3f3ead89f8c497c15a30b69597ec36711a1428ce559641ad6ddf0662a28554b508e86adfde157d181bc7d0f36f1a22fa7f4679c7f54fd0bb828ba1d1865f82be955dde265ae9a771455afeedee18b7a740fe017aff914f0535c4c32dbb77a5cb3b0d9b380d0ae5c6aee77b0010870da1c61d674eae44eb028cb5e433f9b43293f68e77cb8bcfc3bbb16a2f0f79344458ef22c6791aa8e80fa3fe28695af486eebc2521066e3bf5135cde69d8c4695028fd068c057d87cb5b0aeaaf47eab331ce637a456be5ff093670e75c09c7e87a7f0b77de367c0813afe6c331fab97309567b3710693c899e52f670e72d01757783ad5a7bb2b689d3a260f14db17ee3fdfac55509a8af06f068fdf6ff8d491bbc7e1a6cebce3b09cea1dfe0ea7b77d798c6a7f147ee5a93e01c0fc0fb46e79cd4c7f1641433d59cbaaa5b387e79dce2f24ecb264e8bc2b9f1ca334f58e83aeaa847703db2be0b1a901363b01af502b43e6496736a3f3efd3458ad0bcff93cfe0cad0f33e69c0fc51598e6278bc641fc39eee5ce3d24d4718f519deb2e7179a76513a745e18e0e8595335cdebea35e77c4a3f166e8b13dd67b35ff8a3760ee6b27700dfd16df07fa69a19e077d0b7f192a837e9fdf887742abce6a50d742fae9b98eba1ad59df959b818ad44ef0ad435aaf11313ff5cea03eaf542c47ab73ab5da264e8bc269459858e0eb5ddebea23e9afd78069ad6bb5f8d86d1ea8338f34cae21211e1a0ff10a8c3bffa14edd6267625031a53efa1919eb3af34fc43a9b380b0aa86f967a81d5bdb489cbdb27d441dd5a7f819586e936d1b795bac4f433618d3ef3b426e2a3a795fdf0264cfa13414f62afc3bdddb9fb843adc09712c46ebeb6ddac4595048373168a61d4c9789b26f8a57639ac7fc8f4223f1b26f7b0ac44d7f745f8c499f0af4d3464f69bdfd6940d9dd54f0f35dde59d8c45950c8c343a1a5d517178b42b91f84afd7ea310e0dcad11e6e3bb873a6c9114b8d523c0cee9178251a4bf10877ceaea3dc7a3f14ebd3fa527b367116147203c44921faf6eccdcf00caaa0930fa9d3eee683d0d83567fff03ddf9527b88b1a64a6bf8b08637bb7b11a92bf639ee5c5d457935702cfed4d467aaf5271a9b382b0aea7e061ce7f2760de5d41fb06b6ae56ea286a59d5a345573ae73f0d3da88b976517a04ae85bb3f912629f562911acae97ad35a7ffc179b382b0aab2ea75881ceef184419b5cc55d34abc15bdd4fc5fc8a5cf3b827bb13b34ae60b589559aafd2f997b094d1ad033997fd146de2ac28acdee4ba69a49d9d074ed9f43b53b3ee6299eb3e8c5e6ccf5522ee8d063e696ab2bb77158d81b8933bbe0b289b8673c711a4fa2ccde5e9c526b68102ab5fb65e0939cbe5ed02caa62ebe58de8aba634e453eea771cf7487fc8358066a52ec457ba63bb80b2bd2c9455ce7479db6013db40a1770c95905bb0aecbbf4c9469273435184d48d9cf1d97ba8b7bb62f9ac66ce8675c2b0b6ab48932e9e5b3ebf2dcd1e56f834d6c0b05bf2154440e7479978932c56d972b6a40839fcb3054dcbbdf47d388cdf7b96396893269819758ceb9be3bb3896da1f0c787cac89b5dde65a13c4d6befeb85d2c296da4ef3c13ddc0b4db3320f73c72c0be5b93c944fe6ba0fa44d6c0b85d7b8f9389c51ffbf99cbbf6894432f2b9b26a2bcc11d93fa877be966a98a86ad77e2bd0ee558ca67c526b6890aa87ba65e2939c5e55d34caa19964b16ca247ff7bb86352ff702fb782762876f7ba134f0194e394502eb9c2e56d934d6c1395d04294b1625a936ee9cb3d5186a6c5299eeff2a7fee29ebaa9b5b2f4d9aa944123fff4998865dbd3e56f934d6c1b1571a3b54e75791785ebef16ca53f91a8a5975a614dc538df06c5a1865e17b2bd6717d7531c7325debf2b6cd26b68dca687a67aca0567659da5300d7d668be5826c9854c078a7beb3e687299cbbf085c5bdffe6eb7a785743ddbc479a042d7870acae92eefbc71ddbbc0f5fbabcfdfae9b9ffa8f7bab4d4de38b36515b58ca6435ae7b7aad1c9585fd2cb189f340a5dc0b37ed6fbf91cb3f4f5cf3885a19ea5eeff2a7e1e01e6b9f0577ef9fe8f2cf13d7d45a92fa0cc4b22c6cac8c4d9c172aa6b5e762655fe0f2ce13d7743d13727f973f0d07f778ef70cf2b6f71f9e7896bbe2094416e7479e7c526ce0b95d3a20eb1c25acf6de2bdeba6c5b5f432488ffab11c1f76f9d3f070afdd92e9ea265cd80a425c6b63a8edc7722cb45bd226ce0b95d3c09b9b6b95adb4b2d5f138b8d621e1da95135dfe343cdc6bf7cd2b07bbfcf3c0b55cb7a43e1b0b5db3c026ce1315d4c298b1e21aafbd90a700aee3765a955cc2ab10dceba62ee00b5cfeb6711d7dfbbb390a47bafcf36413e7894a6ab7932fd42a5d7985cbdf26aea16bbbc7ae2fbafc69b8b8e79a991adb815ec8cd7db62ad7d0f2e7f1dafa4c2c7ca6ac4d9c372aba7fade2154dd1dccde56f0be7d7cebcf1baf23f5cfe345cdc736d90e2dac2835dfeb6707e3d7db89d980f70f9e7cd262e021576339f3e89b9fd15e4dce7d4ae5537f3be77a95fb8e78f096da0f22a97bf0d9c5b4fa06ec5a285f740546ce22250e9ade1166c789ecb3f2bceab17906eb105ad21dfd925a2d27c70cf3781fb26fe86cbdf06cefd9c702d51efc33d5dfe45b0898b42c54faa05a2a22ebaed5cfe5970ce07d6ae51778dcb9f868f7bff81d0162aadff14e59cda22ddcd483cd9e55f149bb828545e8f44ae4ff66a977f169cf3d9e11a955ead199fdac3bd3f2db485ca092eff2c38a7768e8ed7d15a144bdd3edf262e1201685ab1e508977f5a9cef9270feca2e2e7f1a3eeefdfd425ba85ce8f24f8bf33d2e9c5fd4e697bee2944d5c3402715e2d3015cd90dadce59f06e7725d8f5f737953396803df0c6d426e7279a7c1b9b4b7a476848ed7b8c8e55f349bb868046373b84911adfc25e63cba09ee29e3752e7f2a076de0f5a14d88d6836c65921ae7715f6eb7a2135b99dbc4652020c7d4025437f3cc28cea1edbbdcb95bdf6c31f50b6de0f1a14d54661e0fc039d4eedc17cf5c17fa9c844d5c16027365089468c8e44cfbbd737cd37250735b6f3df5036d6097d0262a33ad5bc9f17aebef9e6ab5047d67f628b489cb4260b45087b6748e41fb34eeec8e1907c7bead76aecacf903bfd148e36a09e288d0589ed63eac1391cab19a76eeabb96246bedbd561b6ce23211206df4e856ebb9d4e51f07c7ba71df1f77795379680b1a811adbc7d42f8839f6e2702ef905f672f997c9262e1b816aadcf9e6334e2d09d2bd7fd4fff89b6f0c6d0362a13bfa8e39867857354963ae0a7894dec0202f6d61040d1d0cd895ece90ffd0daf17527b9fca93cb485e786b65199688e08f9b52dbe1b5efcb72e7f17d8c42e2068eabad312dd31985a3ffd77dc310e79ffac766cdd435dfe541edac2c342dba8bcc4e577c87b4f7caf766ce5ebe8c44e588e4dec0a02b707f4db2906f5e3186bed7ef2b99e05d9c2e54fe5a12d6c19da46e54d2e7f44be3be263b5e32a6abb73dfdc631636b14b0860d3e3d958bfe1c9e7e61a7cd7e54de5529b086d443ee6f246e43b3f1c5799cbccd636d9c4ae21904dabf89ee6f2d791c74d397eafcb9bca459bb826b411f9a1cb5b479ea6094573dfd7af0d36b16b08a61eb19aa66e36f60cf06f4d8f767fe5f2a772a94d843652d9d4e517fecdcdef17b5d55e6c2f6713bb88806a90d06746018eecf44dd235d3d0e53fdae54fe5a24d3c39b491caee0df94f08f92a6aa3bdd95dca26761581d536cfae6740e3ad8f33f9dd0ac4b2f46998a95b68130f0a6da4f20493f738b831fe6a9b5bc5fc5d6613bb8c00ef04b799a26ec83121ef4b6aff5e77af7abe946813db8436527951c8a7496beec3af36b9533d6f1fd8c4ae23d01a2eec9657d234ce5f2f24c27f5f54fbb7ca2fb1f0e59753b7a94dc00de2f9f59474fe5b7b4aaa8dc53c6a8bf6a742d7d9c43e20e007c08d11d007fcb1a33c1faaa557e6b6e863ea37b58dd056e483a37f7b2cd4b6e2bfab0d2e6549ef36d8c4be20f0fa8bec1ec7f497fcd1f84e2dadf22177ae94d436425b11b521b525f774a0b6d7ead2758b6613fb841b70e2e846c49be39e0e64ea598569d8d436425ba9b8b6a436d7fbfd246d62df7023f424d0f4818fce72e748496d23b495266a6bbdfee6afd8c43ee286e89d807b31183dc31d9f92da46682b8eda586f7ff34736b1afb831ea1d705d8475b90d58b2681b0785b612a96df5f26d7f139bd867dc208d137083852a390d3859b48dfd425ba9539bea5d3fff6a6c62df71a33462b069d8b02607ad35ba2b958d3671187e346a2391da52af46f88dcb260e01374c73079a261089d66bcf4d410b471bd044b3d78cda84a336d49bb1fd93b28943c18dd3cd6d9a4a2c9fc3aeeed8347cdcfbfb402b4ebbb6216a3bbd98d5372d9b3834dc442d2ad2d44da8dd88d7984390868f7bfe2434f51aa9ad3cd71d3734367188b8a15a5e6ca597835aca7943776c1a0edd63b8392215b5913ddcb1436413878a1bab8546dd6ac3952fe161eed8d47fbab7a37beceebda86d342e0032443671e8b8c9da77c06d3e52d156e27773c7a6fed1bd1cdd5377af456de1d9eed8a1b38925e0866bd090db86aca21d5c9f8eceece39626a37b37ba87ba97ee1e8bdac0a006f74cc22696821bafaec2a665c32b37e0f7dcf1a9bb74cf46f7ceddd38aeefd60bbf8c661134b4323d02a2f2b0d21d654d057205f12769ceed1e85eb9e9bb15edda9b3d3fb08925a2416c8673e1567ca9686eb8de1f6ce0ce919647f764746fdc1a10154de1d500b04eedd0bb4c36b164340e7517baad9debbe0dad4330e841227da07b30ba17ba27ee5e55b4414ce776e75d369b583a1a8ad6877b266e836b4c956fe278acefce93e647311fc55ef7c0dd9b8ae67e9c845c07d2b089e976349a7b60a5eea38a3680d452d1ebb9f3a4f628c6a3582be6ee5ed45d8eaddd79d2ed6c625a138de821b879d4a856a245255f847bb8f3a4e929a6a3d8ba853ba32f607f779eb4269b98d646835a078fc767e11a5d9dde40ab8b697fe43882292976a3182a962bbdd5afe88fb43683c9c7fd31d9c4d48cc6a546f9287c02ae11465f863690dcd29d2fad4db11ac54cb173318df4d256f3f9f38fed846c621a0f0deee1704b493b1a6e7a19b4ec547623068ac928368ad14ac3b4ebaec781ee7c693c36314d8646f8605c3b6a94e3d014e4ab7034eeeace5902d51dda9453b1504c5cac1cc57a3f77ce34199b98a643a3dc135a44e2e7700dd7d16e33d7e164ece8ce3b24d4717b687d06adb4e376da69a2982ab67bbaf3a6e9d8c4341b1aa94615aa8f7ab5b1e8cee7a111891a9ebc2b7afbbb5665c7ced0b7fc6b71135c9d57a2182a969bb96ba4d9d8c4d41e1aee8e38135f856be0abd160a4f7e2a5d06fe42ddc75ba80b26d8e037106de839566e1ad44b152cc06ff44b46c3631b58fc6ac6fc37d703e561b61b81a4d617d37b498a57e3a68efbaddb089bb769bb8c6c6b83f0e851ee5cfc1bbb0d2421be3504c141bc528dfe62f884d4cf34503d71befc3470d7edcaeae71fd10eaa27c0bf453e2afa06f5375ab9d00bd78d4b51f017dd844ffad34fd9bf228af8ed1b1afc39bf171fc33dc35a7a5ba2b06ba76f68c2c814d4c8b45e3df06faf069adba7146baf595eaa63aaaaedbb858a4c5b28969b9f870e84df9d3a0dd6a579adeda752abbeaa0ba6cefea9a96cb26a66ee1c3b3030e867eefeb91f983586d0fc445525934204a653b052aeb0eae2ea95b6c62ea073e64ea6edc1bea32d4d6d66f83363bd1dc784d83d50218ee033b099d43e7ba05eac67b3b5e8e63a16be7e21a3d6613d330f0e154cfc346d05e89ea8fd742a89ad978088e82b6c316fdb7d2f46fcaa3bc5b43c7e61bf901b38929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b08929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a6944af0abdffa0f50331f92e214a57e0000000049454e44ae426082),
(13, '3252', 0x89504e470d0a1a0a0000000d49484452000001000000010008060000005c72a8660000000467414d410000b18f0bfc61050000290049444154785eeddd79dc345579e6f10404511601410583208b806322a384650c881a500222226e80022a11414565738b01c7046312d4c1510411c880a0801a9720a21351c495b88119f715351a11354e1c63c6fcaed0a5f5deef55cfd34b7577559dfb8fefe703e73d5575ce5da79faeaeb3fdd6af7ef5ab9452a16c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b08929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b089691876d876bbdfc646d80a3b63773c0487e0283c6344ffad34fd9bf228af8ed1b1bfedce9d86c126a67ee0c3b919f6c631380b6fc3e7f06dfc04ff1fbf9a91cea173e99c3ab7aea16be99abaf666ae6ca91f6c62ea163e643be0609c8cf3f1417c1fee03bb0c2a8bcaa4b2a98c2aeb0eae2ea95b6c625a2e3e3cdbe369b814df81fbd0f581caae3aa82edbbbbaa6e5b28969b1f8706c83a37111be01f7611a02d54d75545db771b1488b6513d37cd1f837c0e1d023f397e13e2cd3f825be84ebf02e5c86f3f0d73803cfc37178020ec2be23fa6fa5e9df94e74fa16374accea173e99c3ab7aee1ae3d0dd55d31502c3670b14af3651353fb68e07a23bfcfa8c1df06f78118d70ff061bc11a7e350ec8af5ddb5dba46b8caea56beada2a83caa232b9b28e4b31516c14a3ec7958109b98da4363de1167e2ab700d7f355fc305780af4d67d73779d2e50d946655459556695ddd569358a9562b6a3bb4e6a8f4d4cb3a1e1aa7bee78dc00d7c05752bd387b2aeeedcedf27d4613be80fc225b805aece2b510c15cbec6e9c039b98a64323dd1357e0e7708dd9f921aec289d8d59d7748a8a3061969f091e234c9cf06c554c7ece9ce9ba66313d3646894fbe15ab886eb68608d1e911f8c627fefaaeef8034cfa5e44b1decf9d334dc626a6f1d0080fc4f5a346b99a7fc73538027772e72b996202f5445c8d717b1a14fb03ddf9d2786c626a4683d3b7d661b811ae514637e1346cedce97d646ac340fe15468e8b18b69a47ba17b92bd0713b289696d34ae7571246e866b84753fc6abf14077ae343e62f880512c155317eb3add1bdda375ddb9d2da6c625a130d6a7f7c01aed1d5fd335e8c4ddd79d2f488e95df0228cf3e250f76a7f779eb4269b986e4723da1a978f1ad54ad475a749301bbaf3a4f628c6782ec6e952d4bdcb9f5e2bb089a5a3d1e871ff24e86dbd6b5895af435d5a7774e749f3a398e3e9586d8095eea1ee65fe2c306c62c968287be153708da9a2474ccd87bf833b475a1cdd033c099f87bb5715ddd3bddc394a66134b44e3d030564d7e5969118defe1c958c79d232d0ff744bd33ea625d69fab4eeadee716787532f9a4d2c0d0d42dfe62bbd5c521ffe39b88b3b3e7507f76813bc0a2b8d25d0bd3ec61d5f1a9b580a1a81de2c5f396a144d3e8a07b8e3537771cfee8fd5e662e8de17fd47dd2696801bafc52fbf326a088ec6e8ff317270494fe9de41ab11a97bd6dd63511bd8dd1d5f029b3874dcf067e3ff8d1a40a4df896fc016eed8d43fdccbbb42f30d9adeefa82d3cdb1d3b743671a8b8c99be2ada39bee68d8eedeeed8d47fbab7a37beceebda86d143588cb260e1137760facb4408556b6b9b33b360d07f758938e3413d3b501511bd9c31d3b44367168b8a11a39f68bd10d8efe054f76c7a5e1e29e6b3314dd7bd726d4569eeb8e1b1a9b3814dc448d16d32212ee268b1e0707bf0847f2b8f7bbe0b3a3b6e0a8ed0c7a94a74d1c026e9cbaf83e30ba91ce85c847fec2d106f493402f085d1b11b5a1c17615dac4bee386693ef967463730fa198e76c7a572d126348df8a7a33612a92d6de58eeb3b9bd867dca89dd0f4b24ff3c5efeb8e4b89b6a1f50a9bbe38d4a67672c7f5994dec2b6e9006f734ed99f7f7c8a1bc6945b411ed88fcde519b89d4b6063568c826f61137e600343dc20dfe654e6a0f6d653dbc69d47622b5b103dc717d6413fb861ba259604ddd7caf41cede4b13a1cd6818b12615b936a5b676843bae6f6c629f7023b49e7ed310cf17bb63521a176de8f9a14d55d4e64e74c7f4894dec0b6e80bef9dd875f53419fea8e496952b4a563f16fa3b655a7b6d7eb27019bd807045ebff9dd63ffffc523dd31294d8b3675f0a86dc5f6a636d8db770236b1eb08b8def6bb177eb7e2bfb963529a95dad6a88dc576a7b6d8cbde019bd865045afdfcaeab4f7f9df3c39fe68a36a619851a4c16db9fda64efc609d8c4ae22c01ae1e706f9e8f7d9c1ee9894da465b3b68d4e6623b54dbecd588419bd845045663fb9b46691deb8e49695e68735a1cd6bd80561bedcd80339bd8350454b3fa9a26f63cdf1d93d2bcd1f64e096db1a2b6da8b816736b16b0866d394de57b9fc292d0a6df02f439bac5ce1f2778d4dec1202a9c53c5c8035543317ec6c406cd6c176f843ec87c3713a5e86a7605fe4b6593322861a3178315c1bedfca22236b12b08a096f1727dfd9aacb19e3ba654c4430df1c1f89fd0b6daff8a1837e736bc13cf8376e2cd61d3132266da9de8dd88b155dbedf4f26236b10b089c16f0746ffcf5926523774c8988853ef88fc1a71163358d1fe1ed780eb4b67e3e658d8138dd199f448ca7da7067171ab5895d40d0dceabd1a70b1b3cb5f1ae2a00ffee3a06ffb18a736697f04dd8be3b1a52b4bba1df1d91e7aa28a317cabcbdf053671d90898d6ed8f4194235dfed21007fdb67f5f2d2e8ba2beefaba12eb04d5cd94a475c1e0b17bb4eee3b60139789406998afdbb4e37c97bf24c440dffada8ebc69dd8345d23b8637637fe4cf841ae2f15ac478a94d776eb8b04d5c1602a4c13e6ebb2eaddc7a27774c29a8bfbef5df3f8ac76ad4d8d417fd2778220e81be9976c3bda08954fa8dff7a28b64dd3a9c7a53dfa5f84ec550071d0b815b7c5bcda76a70609d9c46521386ea34eadddbe8bcb5f02eaae6ffd1330ceb7feb77012267a494afe2da06e42f520acb6cffe4a340dfb1d78248aee4da0fef781bb6757bafccb62139781c0688bee182c39cae52f0175d792d557d562d1e4ebd02698ebbbf34c8af3dc1d4fc0b9f812dc3557f3093cd09dbf14d45feb55b8d874666b729bb868046473b8fdf92f70f94b40ddb5a1e56adb5bebd15d4b9ecdb55b94f3ab3bf02ce851df95a3c9bfe31c14bb182b75d746b3312e6aeb9bbbfc8b6613178d609c570b4e45bbf614f9bb9f7aab3be90ba33834f922f671c7cf13d7dc135a2b6fa52db7a3efe289ee7c4347bdf514e736243dcfe55f349bb84804622fc49750faff2277e9a5de7a4977cb280e8e7e676bfcf952ff38727dbde8d2661ad7c195d3d14bc73bb8f30d1975d61a02ae8defe5f22f924d5c1402b02edcdbd222bbfca8f766d0e625311e152d3ad1b9454f2893f6d83b1b1a34e4ca5df71e6cecce3364d4d96d3fa6b6bfaecbbf28367151a8bcde58c7a0e8d1f2ae2eff9051e70df0c1510c1c3df2efe08eed0acab7315e0d3da5b83a54346cb9a82e43eaab773aee67d3492effa2d8c445a0e25be327b540549ee6f20f1df55e6917e38f620b775c1751564d2afaf8a8ec4df4a4d38917618b427dd55313e3a0cfc0d2fe18dac445a0d297d78250d15befe2469551e7a7d66210f56a85990a65d674e467c1cde6ace80f5b312f7aa9abc674b89e9dcb5dfe45b089f34685357c3406418f8df777f9878c3adf136e0289a87fbfd78fca945fcb69af3435f9b5eeb8a1a2beea52753f91f677f9e7cd26ce1315d58b3fd7c555e4ea3ed45b73f1632c44bf17073102927a3c0c1ad1e9ea298f72c70d15f5755b8ee933b1f0178236719ea8a4ba8e62e5bf83e266975167178bcaa1ee98bea23e5a53bfe949477fec8a7929485d3781da7c8cc3c267bbdac479a182fa0de4bab906b1d1e224a8b35691d1d8fd180bb9d41dd377d44b83889ade095ced8e192aeaeb8609ebb3b1d0776036715ea8dc61b5ca5634f9a4c4177f4df3c6356a6eb06fc7a9db0b6a758df674c70c11756dfa323ccce59f179b382f54eec650597992cb3b74d4fb43210e95c35dfea1a07eea1d681aefd0d99573e681faba9f8037babcf36213e7818a1d182a2a9a5c52e2d050f593c758885e040dfe69883a6e0bb7d1a6260f15b3e41b75d50bf12f8fea5e77a0cb3f0f36711ea8d4f5a192f2749777e8a8f745210e9567bafc43445d35d5d8c5e05c977fa8a8af1b1c74bdcb3b0f36b16d5448ebd2c74a6ac24b2f764f6993ea0cd725a637e4c5ac764c5d77469c2023df71f9878afaae876fd6ea5fd9cfe56f9b4d6c1b95b936544e3abf69c23c506ff589c758c8d92eff9051e7a63110bfebf20f15f57d66a8bf5cebf2b6cd26b6898aa8eb27564e0b226ce8f20f1df57e692d0e750f76f9878c3a6b3f03178b935dfea1a2be9a08f6bd5afd2b73ef15b1896da2126e92cb8b5cde1250f74b432c448b786ee0f20f1975deb21683ba6b5cfe21a3cea78618c8dcf717b4896da1029adffef35a85e4c7287989283719e44b2e6f09a8fb3f8658c8f75cde21a3ce1b21aea7a0cfce662e7f5b6c625b28bc7693a957485eedf29682fa6ba04f8cc9fb5dde125077ad1214e321c56dff469d5f116220c7bbbc6db1896da1f0eedbaed89562a9bbdef8ba37df17b9fc25a0eeda9f20c6437673f9878c3adf2fc4406e7079db6213db40c1770c15919b5cde52507f2d101963227feef29780ba3f3ec4a2f218977fe8a8f73f8438c88e2e6f1b6c621b28f499a112729acb5b0aeaaf1d64634ce4652e7f09a8fb3e211695e35cfea1a3deee89e84c97b70d3671561458131de21af21ae659f4d651d47fc35a3ceafec2e52f0175d70e3a2e2647bbfc4347bdb5298b3661adc7429fa5b90c11b789b3a2b0eeaf7a715d3b1131d0a299312e52dc20a00a7577bf7ba5c87d0484babf3bc442e6b207844d9c1585754b201737e73f22065a0822c6455ee3f29780ba6ba110179322df01087577ef45e6b254be4d9c0505d5a8a6b8f28b563e2d7a775f2106dafdb81e97caeb5dfe125077374b541ee9f29780baeb33a4f132f578e833d5fa60319b380b0aa95d66eb059762f7f8ab230e9a0b1f7fdfc9852e7f09a87b532fc0c35dfe52507fb7a760eb6b45d8c4595048f7f85fdc38f726c4e2db2136f2772e6f09a8fb1f8758541ee2f29782faef1be221adff0cb089b3a0907181030d6f2c6ec9af26c4e263b5d8546e76794b40dd4f09b1a83cc8e52f05f5574f5a1c1afc1597771636715a14709b5060b9cae52d15f1785b888ffcd4e52d0175ffef2116959d5cfe921083ab424c645b97775a36715a14eee8505839d1e52d15f1d07efe314652dc7e8842bddd6c512d17b68ecb5f126270622d2695635dde69d9c4695138b7d4d5ae2e6fa988c70b437c2a0f70f9878e7a6bf7a3188b4fbabca5210ebb86b8c8252eefb46ce2b428dc3742618b5ade691cc4e49810a3caa35dfe21a3ce770b31a814db2b12118bb881c82d2edfb46ce23428d8f6a1a032c80d2e66414cdcbe88f21c977fc8a8b3f60d74b1286a45a095100bb7804c6b5bc6d9c4695028b7bae9535dde921193fb8618555ee9f20f19757613c6e40097bf44c4c2ed1c7d82cb3b0d9b380d0ae5fe52dddbe52d1931392ec4a8b2b42da297853aff5d8841e51e2e7f8988c5bd436ce44a97771a36711a142afe56f99acb573262a20541dc4b2f39c71d3364d4f933210695fbbafca5221e5f0bf1d166aaad8cadb18993a2303bd40a57c9e1bf01313936c4a8a24541f772c70c1975bea41683ba97b8fca5221e1784f8482b7f246de2a4288c7b99f31497b764c4a46947a0935cfea1a3de3be197b538543ee5f2978a78b82f8e56664bdac44951989343e1646f97b764c4e413214695ed5cfe125077b72af0cf5cde52118fbd427ce4852eefa46ce2a4288c9b0034d82daea7454c7e1a62244a2b76ae0475bfbc168bbae2f64968422cb4bc7e8ccfc52eefa46ce2a4284cdceef9072e5fe9888bd645a8c7493ee2f29682faff658847652b97bf54c4e39f427c5a693736715214e6fba1701f76f94a475ce2484959d84eb05d44fddd84975f603d97bf54c4e3ba5a7ce456976f5236711214c43d9ebcd1e52d1d71f9548893dce6f29682fa7f3ec4438a9d1edd84989c1762245bbabc93b08993a0107b8742c9e92e6fe9884bd3c097df71f9878e7adf01fab68ff1788bcb5f3262f2bc10239979cd049b38090ae126b71ceaf2968eb89c11e25439d0e51f3aeabd4b8843e50c97bf64c4e48f428c64e6ae769b38090a71562894e4146083b83c3cc4a972aacb3f74d4fbd1210e95c7bafc2523266eb0ddccfb49d8c4495088b8c28d0676aceff2968eb86c0ab7376091b326a977d3da0839143820265a5036eeb4fd7697771236711214e273a150c56e753d0ee2e35e7a7d0fc58d05a0ceefacc5a0923d000d884bfcac7dcee59b844d9c048588abdc5ee7f2a5db119fa625c18ada0d97fa6aa3542dfd15e370a3cb9ffe3366d784587ddbe59b844d9c048588835bdee5f2a5db119f478578555ee5f20f15f53d2ad4bf52ec4ec9ab213671ccc44f5cbe49d8c47151002d5d1c7fd35ee6f2a6db111fed0ee426c068f3d43ddd3143433db501e60f46f58e720f8906c4e6e2102bb599997e3adac47171f18d6a85a99ce7f2a6df20466f0f31ab14f1f84b3d9ba601eb5d48fefe6f406cdccfc78d5cde71d9c47171f1ad4261e4af5ddef41bc4485b62bb013032e83101d46f5bb8272079b23b26dd8ef8bc3cc44b669a336113c7c5c5770e85911cc43106e27476885be5752eff50503fb7d6bd5c8fdc416a05c4e7c5b57855767679c76513c7c5c5770f8591e7b9bc694dc4497328dc5bf099bb76ba8cfab9c93fb2bbcb9f7e83189d14623673dc6ce2b8b8f8434261e4389737ad8d58bd3fc44ef452753397bfefa897dbef4ebeeaf2a7351127b742f04c9ba8dac47171f1434261e4092e6f5a1bb17a49885de52097bfefa8d76ea19e95735dfeb426e2f4b8103739c4e51d974d1c1717777db9836cbcf340acf60bb1abbcdce5ef3beae566b4492bebdb0d1d717213828e7279c76513c7c5c59f110a23fbbabc696dc46a036845e018c38fbafc7d47bde2ca51a21e8141fee4691b71dab716b7ca335cde71d9c471e9e2a130927f002640bcdc87425adbfea90ba8cfef86fa5506f9c76e1e8855e7fe00b89f0007bbbcc9235ecf0af1ab9cedf2f715f53937d4af52dc9e88d322560785d8c9527f02b897804f74799347bcee0af73340bbbfdcd11dd337d443c39fff6554af3a7583e6e3ff9888d5136ab1ab2cf525a0eb067cbacb9b9a11b3a6bef1235dfebea11eaeff5a2e72f99347bcdcbe924bed067403818a5cdd6616c4ec91218695de4fada60eebe28bb53ad51531f9a92dc4ebb9217eb2d481406e28f04b5dded48c9869714c4d8489b1945e7f4828ff09a13e95dcfe6b42c4cc8d1b59ea50603719a8a879ed6d216ecf0f71ac7c04bd1c234fb937871bf92747b863523362e6365159ea6420371d3877059e0271bb33e216eb955e7e5828f76b433d2ada233127fe4c8898b99e94a54e07760b825ce1f2a6d5113b37ae42be853bbb63ba8af2fe1e9aa6fdeee38e492b236e9786382e774110a1007149b06b5cbeb43a62b71ebe528b65dd9fba63ba88b2ea8be103b5b2d7bdd51d935647ecde1162b9dc25c18442c445416f70f9d27888df91219e959fe13eee98aea19c2fa895bb4e8ba0ece48e49ab23767f5f8ba5746251d0b854f1575cbe341ee2a76f4f374d5814eb4eff14a07c7f88a647ff5cf07306c4efe610cf4e2c0b1e3706d1ef92418c605b16e2a765b3dc56e2f237ee982ea06cdba069b14fbdf8cbf5fea644ec349e228e18edc4c6206e6bb0fbb9bc697cc4f06921a675c7bb63968932ad8f8fd5ca58f753e4a3ff0c889fd6918c71edc4d6606e73d0c35dde3419e27875886b455b447566092dcaa29f2d6f1c95cd39d61d97c6470cdd7e129dd81cd46d0ffe6297374d8638de13b7d6e25aa79183ffc51db74894417bd65d382a93935b7db78038ba81629dd81e5c8b5bc68215b9d9e53c10cbeb426cebf47b7b695b8a716d0d61be6c541647ef83eeee8e4d93218e17d5e25ad9d2e59d844d9c1405f97e2858eeefd602e2784088aba32784df77c7cf13d7d46ffef802d879a83b3e4d8638c6f72bb7ba7c93b28993a23071551bcdfdcea19e33207e1a47af1180f5b836f931fec09d671eb896d63078cfe8daabd1f0e6addd79d2f88861ec15fa88cb37299b38290a737e289c6ce3f2a6d511bb5df18fb5588e43836cf43b711d77ceb670fe83f15db83234f914b673e74bab23767a1714637ab1cb3b299b38290a7372289ceceff2a666c44c7dbd4f47d31800893fb7223d8db5fe61e39c9b60a537fdabf91172f5df2910370dae8af17ca1cb3b299b38290aa36f8558c067b9bcc9235e07e2a65afc9c2ba15983ab7d10f507e458ccfc338c73e82dbfbaa0be0177ad8ade45dc16d21c6d8c3ad31cf6d2102fb76e642b7f4c6de2a428cc0ea17072a1cb9bd6449c346beebdb5b835792bee503b4eabc3340db9ad68251e359e8debd71c07c76c81d3f055b873d76994dff6d05382e6acc719a2d1bf415385efe6ae9dd6449c5c37eb7d5dde49d9c46950a03897fd5b2e5fba1df1b9172e80bacaea7173f4adb9d6305ad21e0e3d5abb63eaf492f095d8137789e7199d4b5d7afa43aecd27fe061a6ce4ce15e9bceb8773a9f7a26985a33a3da968cbebff5a3f3ead89f8c497c15a30b69597ec36711a1428ce559641ad6ddf0662a28554b508e86adfde157d181bc7d0f36f1a22fa7f4679c7f54fd0bb828ba1d1865f82be955dde265ae9a771455afeedee18b7a740fe017aff914f0535c4c32dbb77a5cb3b0d9b380d0ae5c6aee77b0010870da1c61d674eae44eb028cb5e433f9b43293f68e77cb8bcfc3bbb16a2f0f79344458ef22c6791aa8e80fa3fe28695af486eebc2521066e3bf5135cde69d8c4695028fd068c057d87cb5b0aeaaf47eab331ce637a456be5ff093670e75c09c7e87a7f0b77de367c0813afe6c331fab97309567b3710693c899e52f670e72d01757783ad5a7bb2b689d3a260f14db17ee3fdfac55509a8af06f068fdf6ff8d491bbc7e1a6cebce3b09cea1dfe0ea7b77d798c6a7f147ee5a93e01c0fc0fb46e79cd4c7f1641433d59cbaaa5b387e79dce2f24ecb264e8bc2b9f1ca334f58e83aeaa847703db2be0b1a901363b01af502b43e6496736a3f3efd3458ad0bcff93cfe0cad0f33e69c0fc51598e6278bc641fc39eee5ce3d24d4718f519deb2e7179a76513a745e18e0e8595335cdebea35e77c4a3f166e8b13dd67b35ff8a3760ee6b27700dfd16df07fa69a19e077d0b7f192a837e9fdf887742abce6a50d742fae9b98eba1ad59df959b818ad44ef0ad435aaf11313ff5cea03eaf542c47ab73ab5da264e8bc269459858e0eb5ddebea23e9afd78069ad6bb5f8d86d1ea8338f34cae21211e1a0ff10a8c3bffa14edd6267625031a53efa1919eb3af34fc43a9b380b0aa86f967a81d5bdb489cbdb27d441dd5a7f819586e936d1b795bac4f433618d3ef3b426e2a3a795fdf0264cfa13414f62afc3bdddb9fb843adc09712c46ebeb6ddac4595048373168a61d4c9789b26f8a57639ac7fc8f4223f1b26f7b0ac44d7f745f8c499f0af4d3464f69bdfd6940d9dd54f0f35dde59d8c45950c8c343a1a5d517178b42b91f84afd7ea310e0dcad11e6e3bb873a6c9114b8d523c0cee9178251a4bf10877ceaea3dc7a3f14ebd3fa527b367116147203c44921faf6eccdcf00caaa0930fa9d3eee683d0d83567fff03ddf9527b88b1a64a6bf8b08637bb7b11a92bf639ee5c5d457935702cfed4d467aaf5271a9b382b0aea7e061ce7f2760de5d41fb06b6ae56ea286a59d5a345573ae73f0d3da88b976517a04ae85bb3f912629f562911acae97ad35a7ffc179b382b0aab2ea75881ceef184419b5cc55d34abc15bdd4fc5fc8a5cf3b827bb13b34ae60b589559aafd2f997b094d1ad033997fd146de2ac28acdee4ba69a49d9d074ed9f43b53b3ee6299eb3e8c5e6ccf5522ee8d063e696ab2bb77158d81b8933bbe0b289b8673c711a4fa2ccde5e9c526b68102ab5fb65e0939cbe5ed02caa62ebe58de8aba634e453eea771cf7487fc8358066a52ec457ba63bb80b2bd2c9455ce7479db6013db40a1770c95905bb0aecbbf4c9469273435184d48d9cf1d97ba8b7bb62f9ac66ce8675c2b0b6ab48932e9e5b3ebf2dcd1e56f834d6c0b05bf2154440e7479978932c56d972b6a40839fcb3054dcbbdf47d388cdf7b96396893269819758ceb9be3bb3896da1f0c787cac89b5dde65a13c4d6befeb85d2c296da4ef3c13ddc0b4db3320f73c72c0be5b93c944fe6ba0fa44d6c0b85d7b8f9389c51ffbf99cbbf6894432f2b9b26a2bcc11d93fa877be966a98a86ad77e2bd0ee558ca67c526b6890aa87ba65e2939c5e55d34caa19964b16ca247ff7bb86352ff702fb782762876f7ba134f0194e394502eb9c2e56d934d6c1395d04294b1625a936ee9cb3d5186a6c5299eeff2a7fee29ebaa9b5b2f4d9aa944123fff4998865dbd3e56f934d6c1b1571a3b54e75791785ebef16ca53f91a8a5975a614dc538df06c5a1865e17b2bd6717d7531c7325debf2b6cd26b68dca687a67aca0567659da5300d7d668be5826c9854c078a7beb3e687299cbbf085c5bdffe6eb7a785743ddbc479a042d7870acae92eefbc71ddbbc0f5fbabcfdfae9b9ffa8f7bab4d4de38b36515b58ca6435ae7b7aad1c9585fd2cb189f340a5dc0b37ed6fbf91cb3f4f5cf3885a19ea5eeff2a7e1e01e6b9f0577ef9fe8f2cf13d7d45a92fa0cc4b22c6cac8c4d9c172aa6b5e762655fe0f2ce13d7743d13727f973f0d07f778ef70cf2b6f71f9e7896bbe2094416e7479e7c526ce0b95d3a20eb1c25acf6de2bdeba6c5b5f432488ffab11c1f76f9d3f070afdd92e9ea265cd80a425c6b63a8edc7722cb45bd226ce0b95d3c09b9b6b95adb4b2d5f138b8d621e1da95135dfe343cdc6bf7cd2b07bbfcf3c0b55cb7a43e1b0b5db3c026ce1315d4c298b1e21aafbd90a700aee3765a955cc2ab10dceba62ee00b5cfeb6711d7dfbbb390a47bafcf36413e7894a6ab7932fd42a5d7985cbdf26aea16bbbc7ae2fbafc69b8b8e79a991adb815ec8cd7db62ad7d0f2e7f1dafa4c2c7ca6ac4d9c372aba7fade2154dd1dccde56f0be7d7cebcf1baf23f5cfe345cdc736d90e2dac2835dfeb6707e3d7db89d980f70f9e7cd262e021576339f3e89b9fd15e4dce7d4ae5537f3be77a95fb8e78f096da0f22a97bf0d9c5b4fa06ec5a285f740546ce22250e9ade1166c789ecb3f2bceab17906eb105ad21dfd925a2d27c70cf3781fb26fe86cbdf06cefd9c702d51efc33d5dfe45b0898b42c54faa05a2a22ebaed5cfe5970ce07d6ae51778dcb9f868f7bff81d0162aadff14e59cda22ddcd483cd9e55f149bb828545e8f44ae4ff66a977f169cf3d9e11a955ead199fdac3bd3f2db485ca092eff2c38a7768e8ed7d15a144bdd3edf262e1201685ab1e508977f5a9cef9270feca2e2e7f1a3eeefdfd425ba85ce8f24f8bf33d2e9c5fd4e697bee2944d5c3402715e2d3015cd90dadce59f06e7725d8f5f737953396803df0c6d426e7279a7c1b9b4b7a476848ed7b8c8e55f349bb868046373b84911adfc25e63cba09ee29e3752e7f2a076de0f5a14d88d6836c65921ae7715f6eb7a2135b99dbc4652020c7d4025437f3cc28cea1edbbdcb95bdf6c31f50b6de0f1a14d54661e0fc039d4eedc17cf5c17fa9c844d5c16027365089468c8e44cfbbd737cd37250735b6f3df5036d6097d0262a33ad5bc9f17aebef9e6ab5047d67f628b489cb4260b45087b6748e41fb34eeec8e1907c7bead76aecacf903bfd148e36a09e288d0589ed63eac1391cab19a76eeabb96246bedbd561b6ce23211206df4e856ebb9d4e51f07c7ba71df1f77795379680b1a811adbc7d42f8839f6e2702ef905f672f997c9262e1b816aadcf9e6334e2d09d2bd7fd4fff89b6f0c6d0362a13bfa8e39867857354963ae0a7894dec0202f6d61040d1d0cd895ece90ffd0daf17527b9fca93cb485e786b65199688e08f9b52dbe1b5efcb72e7f17d8c42e2068eabad312dd31985a3ffd77dc310e79ffac766cdd435dfe541edac2c342dba8bcc4e577c87b4f7caf766ce5ebe8c44e588e4dec0a02b707f4db2906f5e3186bed7ef2b99e05d9c2e54fe5a12d6c19da46e54d2e7f44be3be263b5e32a6abb73dfdc631636b14b0860d3e3d958bfe1c9e7e61a7cd7e54de5529b086d443ee6f246e43b3f1c5799cbccd636d9c4ae21904dabf89ee6f2d791c74d397eafcb9bca459bb826b411f9a1cb5b479ea6094573dfd7af0d36b16b08a61eb19aa66e36f60cf06f4d8f767fe5f2a772a94d843652d9d4e517fecdcdef17b5d55e6c2f6713bb88806a90d06746018eecf44dd235d3d0e53fdae54fe5a24d3c39b491caee0df94f08f92a6aa3bdd95dca26761581d536cfae6740e3ad8f33f9dd0ac4b2f46998a95b68130f0a6da4f20493f738b831fe6a9b5bc5fc5d6613bb8c00ef04b799a26ec83121ef4b6aff5e77af7abe946813db8436527951c8a7496beec3af36b9533d6f1fd8c4ae23d01a2eec9657d234ce5f2f24c27f5f54fbb7ca2fb1f0e59753b7a94dc00de2f9f59474fe5b7b4aaa8dc53c6a8bf6a742d7d9c43e20e007c08d11d007fcb1a33c1faaa557e6b6e863ea37b58dd056e483a37f7b2cd4b6e2bfab0d2e6549ef36d8c4be20f0fa8bec1ec7f497fcd1f84e2dadf22177ae94d436425b11b521b525f774a0b6d7ead2758b6613fb841b70e2e846c49be39e0e64ea598569d8d436425ba9b8b6a436d7fbfd246d62df7023f424d0f4818fce72e748496d23b495266a6bbdfee6afd8c43ee286e89d807b31183dc31d9f92da46682b8eda586f7ff34736b1afb831ea1d705d8475b90d58b2681b0785b612a96df5f26d7f139bd867dc208d137083852a390d3859b48dfd425ba9539bea5d3fff6a6c62df71a33462b069d8b02607ad35ba2b958d3671187e346a2391da52af46f88dcb260e01374c73079a261089d66bcf4d410b471bd044b3d78cda84a336d49bb1fd93b28943c18dd3cd6d9a4a2c9fc3aeeed8347cdcfbfb402b4ebbb6216a3bbd98d5372d9b3834dc442d2ad2d44da8dd88d7984390868f7bfe2434f51aa9ad3cd71d3734367188b8a15a5e6ca597835aca7943776c1a0edd63b8392215b5913ddcb1436413878a1bab8546dd6ac3952fe161eed8d47fbab7a37beceebda86d342e0032443671e8b8c9da77c06d3e52d156e27773c7a6fed1bd1cdd5377af456de1d9eed8a1b38925e0866bd090db86aca21d5c9f8eceece39626a37b37ba87ba97ee1e8bdac0a006f74cc22696821bafaec2a665c32b37e0f7dcf1a9bb74cf46f7ceddd38aeefd60bbf8c661134b4323d02a2f2b0d21d654d057205f12769ceed1e85eb9e9bb15edda9b3d3fb08925a2416c8673e1567ca9686eb8de1f6ce0ce919647f764746fdc1a10154de1d500b04eedd0bb4c36b164340e7517baad9debbe0dad4330e841227da07b30ba17ba27ee5e55b4414ce776e75d369b583a1a8ad6877b266e836b4c956fe278acefce93e647311fc55ef7c0dd9b8ae67e9c845c07d2b089e976349a7b60a5eea38a3680d452d1ebb9f3a4f628c6a3582be6ee5ed45d8eaddd79d2ed6c625a138de821b879d4a856a245255f847bb8f3a4e929a6a3d8ba853ba32f607f779eb4269b98d646835a078fc767e11a5d9dde40ab8b697fe43882292976a3182a962bbdd5afe88fb43683c9c7fd31d9c4d48cc6a546f9287c02ae11465f863690dcd29d2fad4db11ac54cb173318df4d256f3f9f38fed846c621a0f0deee1704b493b1a6e7a19b4ec547623068ac928368ad14ac3b4ebaec781ee7c693c36314d8646f8605c3b6a94e3d014e4ab7034eeeace5902d51dda9453b1504c5cac1cc57a3f77ce34199b98a643a3dc135a44e2e7700dd7d16e33d7e164ece8ce3b24d4717b687d06adb4e376da69a2982ab67bbaf3a6e9d8c4341b1aa94615aa8f7ab5b1e8cee7a111891a9ebc2b7afbbb5665c7ced0b7fc6b71135c9d57a2182a969bb96ba4d9d8c4d41e1aee8e38135f856be0abd160a4f7e2a5d06fe42ddc75ba80b26d8e037106de839566e1ad44b152cc06ff44b46c3631b58fc6ac6fc37d703e561b61b81a4d617d37b498a57e3a68efbaddb089bb769bb8c6c6b83f0e851ee5cfc1bbb0d2421be3504c141bc528dfe62f884d4cf34503d71befc3470d7edcaeae71fd10eaa27c0bf453e2afa06f5375ab9d00bd78d4b51f017dd844ffad34fd9bf228af8ed1b1afc39bf171fc33dc35a7a5ba2b06ba76f68c2c814d4c8b45e3df06faf069adba7146baf595eaa63aaaaedbb858a4c5b28969b9f870e84df9d3a0dd6a579adeda752abbeaa0ba6cefea9a96cb26a66ee1c3b3030e867eefeb91f983586d0fc445525934204a653b052aeb0eae2ea95b6c62ea073e64ea6edc1bea32d4d6d66f83363bd1dc784d83d50218ee033b099d43e7ba05eac67b3b5e8e63a16be7e21a3d6613d330f0e154cfc346d05e89ea8fd742a89ad978088e82b6c316fdb7d2f46fcaa3bc5b43c7e61bf901b38929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b08929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a6944af0abdffa0f50331f92e214a57e0000000049454e44ae426082);
INSERT INTO `timages` (`ID`, `EmployeeID`, `ProfilePicture`) VALUES
(14, '13-33466', 0x89504e470d0a1a0a0000000d49484452000001000000010008060000005c72a8660000000467414d410000b18f0bfc61050000290049444154785eeddd79dc345579e6f10404511601410583208b806322a384650c881a500222226e80022a11414565738b01c7046312d4c1510411c880a0801a9720a21351c495b88119f715351a11354e1c63c6fcaed0a5f5deef55cfd34b7577559dfb8fefe703e73d5575ce5da79faeaeb3fdd6af7ef5ab9452a16c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b08929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b089691876d876bbdfc646d80a3b63773c0487e0283c6344ffad34fd9bf228af8ed1b1bfedce9d86c126a67ee0c3b919f6c631380b6fc3e7f06dfc04ff1fbf9a91cea173e99c3ab7aea16be99abaf666ae6ca91f6c62ea163e643be0609c8cf3f1417c1fee03bb0c2a8bcaa4b2a98c2aeb0eae2ea95b6c625a2e3e3cdbe369b814df81fbd0f581caae3aa82edbbbbaa6e5b28969b1f8706c83a37111be01f7611a02d54d75545db771b1488b6513d37cd1f837c0e1d023f397e13e2cd3f825be84ebf02e5c86f3f0d73803cfc37178020ec2be23fa6fa5e9df94e74fa16374accea173e99c3ab7aee1ae3d0dd55d31502c3670b14af3651353fb68e07a23bfcfa8c1df06f78118d70ff061bc11a7e350ec8af5ddb5dba46b8caea56beada2a83caa232b9b28e4b31516c14a3ec7958109b98da4363de1167e2ab700d7f355fc305780af4d67d73779d2e50d946655459556695ddd569358a9562b6a3bb4e6a8f4d4cb3a1e1aa7bee78dc00d7c05752bd387b2aeeedcedf27d4613be80fc225b805aece2b510c15cbec6e9c039b98a64323dd1357e0e7708dd9f921aec289d8d59d7748a8a3061969f091e234c9cf06c554c7ece9ce9ba66313d3646894fbe15ab886eb68608d1e911f8c627fefaaeef8034cfa5e44b1decf9d334dc626a6f1d0080fc4f5a346b99a7fc73538027772e72b996202f5445c8d717b1a14fb03ddf9d2786c626a4683d3b7d661b811ae514637e1346cedce97d646ac340fe15468e8b18b69a47ba17b92bd0713b289696d34ae7571246e866b84753fc6abf14077ae343e62f880512c155317eb3add1bdda375ddb9d2da6c625a130d6a7f7c01aed1d5fd335e8c4ddd79d2f488e95df0228cf3e250f76a7f779eb4269b986e4723da1a978f1ad54ad475a749301bbaf3a4f628c6782ec6e952d4bdcb9f5e2bb089a5a3d1e871ff24e86dbd6b5895af435d5a7774e749f3a398e3e9586d8095eea1ee65fe2c306c62c968287be153708da9a2474ccd87bf833b475a1cdd033c099f87bb5715ddd3bddc394a66134b44e3d030564d7e5969118defe1c958c79d232d0ff744bd33ea625d69fab4eeadee716787532f9a4d2c0d0d42dfe62bbd5c521ffe39b88b3b3e7507f76813bc0a2b8d25d0bd3ec61d5f1a9b580a1a81de2c5f396a144d3e8a07b8e3537771cfee8fd5e662e8de17fd47dd2696801bafc52fbf326a088ec6e8ff317270494fe9de41ab11a97bd6dd63511bd8dd1d5f029b3874dcf067e3ff8d1a40a4df896fc016eed8d43fdccbbb42f30d9adeefa82d3cdb1d3b743671a8b8c99be2ada39bee68d8eedeeed8d47fbab7a37beceebda86d143588cb260e1137760facb4408556b6b9b33b360d07f758938e3413d3b501511bd9c31d3b44367168b8a11a39f68bd10d8efe054f76c7a5e1e29e6b3314dd7bd726d4569eeb8e1b1a9b3814dc448d16d32212ee268b1e0707bf0847f2b8f7bbe0b3a3b6e0a8ed0c7a94a74d1c026e9cbaf83e30ba91ce85c847fec2d106f493402f085d1b11b5a1c17615dac4bee386693ef967463730fa198e76c7a572d126348df8a7a33612a92d6de58eeb3b9bd867dca89dd0f4b24ff3c5efeb8e4b89b6a1f50a9bbe38d4a67672c7f5994dec2b6e9006f734ed99f7f7c8a1bc6945b411ed88fcde519b89d4b6063568c826f61137e600343dc20dfe654e6a0f6d653dbc69d47622b5b103dc717d6413fb861ba259604ddd7caf41cede4b13a1cd6818b12615b936a5b676843bae6f6c629f7023b49e7ed310cf17bb63521a176de8f9a14d55d4e64e74c7f4894dec0b6e80bef9dd875f53419fea8e496952b4a563f16fa3b655a7b6d7eb27019bd807045ebff9dd63ffffc523dd31294d8b3675f0a86dc5f6a636d8db770236b1eb08b8def6bb177eb7e2bfb963529a95dad6a88dc576a7b6d8cbde019bd865045afdfcaeab4f7f9df3c39fe68a36a619851a4c16db9fda64efc609d8c4ae22c01ae1e706f9e8f7d9c1ee9894da465b3b68d4e6623b54dbecd588419bd845045663fb9b46691deb8e49695e68735a1cd6bd80561bedcd80339bd8350454b3fa9a26f63cdf1d93d2bcd1f64e096db1a2b6da8b816736b16b0866d394de57b9fc292d0a6df02f439bac5ce1f2778d4dec1202a9c53c5c8035543317ec6c406cd6c176f843ec87c3713a5e86a7605fe4b6593322861a3178315c1bedfca22236b12b08a096f1727dfd9aacb19e3ba654c4430df1c1f89fd0b6daff8a1837e736bc13cf8376e2cd61d3132266da9de8dd88b155dbedf4f26236b10b089c16f0746ffcf5926523774c8988853ef88fc1a71163358d1fe1ed780eb4b67e3e658d8138dd199f448ca7da7067171ab5895d40d0dceabd1a70b1b3cb5f1ae2a00ffee3a06ffb18a736697f04dd8be3b1a52b4bba1df1d91e7aa28a317cabcbdf053671d90898d6ed8f4194235dfed21007fdb67f5f2d2e8ba2beefaba12eb04d5cd94a475c1e0b17bb4eee3b60139789406998afdbb4e37c97bf24c440dffada8ebc69dd8345d23b8637637fe4cf841ae2f15ac478a94d776eb8b04d5c1602a4c13e6ebb2eaddc7a27774c29a8bfbef5df3f8ac76ad4d8d417fd2778220e81be9976c3bda08954fa8dff7a28b64dd3a9c7a53dfa5f84ec550071d0b815b7c5bcda76a70609d9c46521386ea34eadddbe8bcb5f02eaae6ffd1330ceb7feb77012267a494afe2da06e42f520acb6cffe4a340dfb1d78248aee4da0fef781bb6757bafccb62139781c0688bee182c39cae52f0175d792d557d562d1e4ebd02698ebbbf34c8af3dc1d4fc0b9f812dc3557f3093cd09dbf14d45feb55b8d874666b729bb868046473b8fdf92f70f94b40ddb5a1e56adb5bebd15d4b9ecdb55b94f3ab3bf02ce851df95a3c9bfe31c14bb182b75d746b3312e6aeb9bbbfc8b6613178d609c570b4e45bbf614f9bb9f7aab3be90ba33834f922f671c7cf13d7dc135a2b6fa52db7a3efe289ee7c4347bdf514e736243dcfe55f349bb84804622fc49750faff2277e9a5de7a4977cb280e8e7e676bfcf952ff38727dbde8d2661ad7c195d3d14bc73bb8f30d1975d61a02ae8defe5f22f924d5c1402b02edcdbd222bbfca8f766d0e625311e152d3ad1b9454f2893f6d83b1b1a34e4ca5df71e6cecce3364d4d96d3fa6b6bfaecbbf28367151a8bcde58c7a0e8d1f2ae2eff9051e70df0c1510c1c3df2efe08eed0acab7315e0d3da5b83a54346cb9a82e43eaab773aee67d3492effa2d8c445a0e25be327b540549ee6f20f1df55e6917e38f620b775c1751564d2afaf8a8ec4df4a4d38917618b427dd55313e3a0cfc0d2fe18dac445a0d297d78250d15befe2469551e7a7d66210f56a85990a65d674e467c1cde6ace80f5b312f7aa9abc674b89e9dcb5dfe45b089f34685357c3406418f8df777f9878c3adf136e0289a87fbfd78fca945fcb69af3435f9b5eeb8a1a2beea52753f91f677f9e7cd26ce1315d58b3fd7c555e4ea3ed45b73f1632c44bf17073102927a3c0c1ad1e9ea298f72c70d15f5755b8ee933b1f0178236719ea8a4ba8e62e5bf83e266975167178bcaa1ee98bea23e5a53bfe949477fec8a7929485d3781da7c8cc3c267bbdac479a182fa0de4bab906b1d1e224a8b35691d1d8fd180bb9d41dd377d44b83889ade095ced8e192aeaeb8609ebb3b1d0776036715ea8dc61b5ca5634f9a4c4177f4df3c6356a6eb06fc7a9db0b6a758df674c70c11756dfa323ccce59f179b382f54eec650597992cb3b74d4fb43210e95c35dfea1a07eea1d681aefd0d99573e681faba9f8037babcf36213e7818a1d182a2a9a5c52e2d050f593c758885e040dfe69883a6e0bb7d1a6260f15b3e41b75d50bf12f8fea5e77a0cb3f0f36711ea8d4f5a192f2749777e8a8f745210e9567bafc43445d35d5d8c5e05c977fa8a8af1b1c74bdcb3b0f36b16d5448ebd2c74a6ac24b2f764f6993ea0cd725a637e4c5ac764c5d77469c2023df71f9878afaae876fd6ea5fd9cfe56f9b4d6c1b95b936544e3abf69c23c506ff589c758c8d92eff9051e7a63110bfebf20f15f57d66a8bf5cebf2b6cd26b6898aa8eb27564e0b226ce8f20f1df57e692d0e750f76f9878c3a6b3f03178b935dfea1a2be9a08f6bd5afd2b73ef15b1896da2126e92cb8b5cde1250f74b432c448b786ee0f20f1975deb21683ba6b5cfe21a3cea78618c8dcf717b4896da1029adffef35a85e4c7287989283719e44b2e6f09a8fb3f8658c8f75cde21a3ce1b21aea7a0cfce662e7f5b6c625b28bc7693a957485eedf29682fa6ba04f8cc9fb5dde125077ad1214e321c56dff469d5f116220c7bbbc6db1896da1f0eedbaed89562a9bbdef8ba37df17b9fc25a0eeda9f20c6437673f9878c3adf2fc4406e7079db6213db40c1770c15919b5cde52507f2d101963227feef29780ba3f3ec4a2f218977fe8a8f73f8438c88e2e6f1b6c621b28f499a112729acb5b0aeaaf1d64634ce4652e7f09a8fb3e211695e35cfea1a3deee89e84c97b70d3671561458131de21af21ae659f4d651d47fc35a3ceafec2e52f0175d70e3a2e2647bbfc4347bdb5298b3661adc7429fa5b90c11b789b3a2b0eeaf7a715d3b1131d0a299312e52dc20a00a7577bf7ba5c87d0484babf3bc442e6b207844d9c1585754b201737e73f22065a0822c6455ee3f29780ba6ba110179322df01087577ef45e6b254be4d9c0505d5a8a6b8f28b563e2d7a775f2106dafdb81e97caeb5dfe125077374b541ee9f29780baeb33a4f132f578e833d5fa60319b380b0aa95d66eb059762f7f8ab230e9a0b1f7fdfc9852e7f09a87b532fc0c35dfe52507fb7a760eb6b45d8c4595048f7f85fdc38f726c4e2db2136f2772e6f09a8fb1f8758541ee2f29782faef1be221adff0cb089b3a0907181030d6f2c6ec9af26c4e263b5d8546e76794b40dd4f09b1a83cc8e52f05f5574f5a1c1afc1597771636715a14709b5060b9cae52d15f1785b888ffcd4e52d0175ffef2116959d5cfe921083ab424c645b97775a36715a14eee8505839d1e52d15f1d07efe314652dc7e8842bddd6c512d17b68ecb5f126270622d2695635dde69d9c4695138b7d4d5ae2e6fa988c70b437c2a0f70f9878e7a6bf7a3188b4fbabca5210ebb86b8c8252eefb46ce2b428dc3742618b5ade691cc4e49810a3caa35dfe21a3ce770b31a814db2b12118bb881c82d2edfb46ce23428d8f6a1a032c80d2e66414cdcbe88f21c977fc8a8b3f60d74b1286a45a095100bb7804c6b5bc6d9c4695028b7bae9535dde921193fb8618555ee9f20f19757613c6e40097bf44c4c2ed1c7d82cb3b0d9b380d0ae5fe52dddbe52d1931392ec4a8b2b42da297853aff5d8841e51e2e7f8988c5bd436ce44a97771a36711a142afe56f99acb573262a20541dc4b2f39c71d3364d4f933210695fbbafca5221e5f0bf1d166aaad8cadb18993a2303bd40a57c9e1bf01313936c4a8a24541f772c70c1975bea41683ba97b8fca5221e1784f8482b7f246de2a4288c7b99f31497b764c4a46947a0935cfea1a3de3be197b538543ee5f2978a78b82f8e56664bdac44951989343e1646f97b764c4e413214695ed5cfe125077b72af0cf5cde52118fbd427ce4852eefa46ce2a4288c9b0034d82daea7454c7e1a62244a2b76ae0475bfbc168bbae2f64968422cb4bc7e8ccfc52eefa46ce2a4284cdceef9072e5fe9888bd645a8c7493ee2f29682faff658847652b97bf54c4e39f427c5a693736715214e6fba1701f76f94a475ce2484959d84eb05d44fddd84975f603d97bf54c4e3ba5a7ce456976f5236711214c43d9ebcd1e52d1d71f9548893dce6f29682fa7f3ec4438a9d1edd84989c1762245bbabc93b08993a0107b8742c9e92e6fe9884bd3c097df71f9878e7adf01fab68ff1788bcb5f3262f2bc10239979cd049b38090ae126b71ceaf2968eb89c11e25439d0e51f3aeabd4b8843e50c97bf64c4e48f428c64e6ae769b38090a71562894e4146083b83c3cc4a972aacb3f74d4fbd1210e95c7bafc2523266eb0ddccfb49d8c4495088b8c28d0676aceff2968eb86c0ab7376091b326a977d3da0839143820265a5036eeb4fd7697771236711214e273a150c56e753d0ee2e35e7a7d0fc58d05a0ceefacc5a0923d000d884bfcac7dcee59b844d9c048588abdc5ee7f2a5db119fa625c18ada0d97fa6aa3542dfd15e370a3cb9ffe3366d784587ddbe59b844d9c048588835bdee5f2a5db119f478578555ee5f20f15f53d2ad4bf52ec4ec9ab213671ccc44f5cbe49d8c47151002d5d1c7fd35ee6f2a6db111fed0ee426c068f3d43ddd3143433db501e60f46f58e720f8906c4e6e2102bb599997e3adac47171f18d6a85a99ce7f2a6df20466f0f31ab14f1f84b3d9ba601eb5d48fefe6f406cdccfc78d5cde71d9c47171f1ad4261e4af5ddef41bc4485b62bb013032e83101d46f5bb8272079b23b26dd8ef8bc3cc44b669a336113c7c5c5770e85911cc43106e27476885be5752eff50503fb7d6bd5c8fdc416a05c4e7c5b57855767679c76513c7c5c5770f8591e7b9bc694dc4497328dc5bf099bb76ba8cfab9c93fb2bbcb9f7e83189d14623673dc6ce2b8b8f8434261e4389737ad8d58bd3fc44ef452753397bfefa897dbef4ebeeaf2a7351127b742f04c9ba8dac47171f1434261e4092e6f5a1bb17a49885de52097bfefa8d76ea19e95735dfeb426e2f4b8103739c4e51d974d1c1717777db9836cbcf340acf60bb1abbcdce5ef3beae566b4492bebdb0d1d717213828e7279c76513c7c5c59f110a23fbbabc696dc46a036845e018c38fbafc7d47bde2ca51a21e8141fee4691b71dab716b7ca335cde71d9c471e9e2a130927f002640bcdc87425adbfea90ba8cfef86fa5506f9c76e1e8855e7fe00b89f0007bbbcc9235ecf0af1ab9cedf2f715f53937d4af52dc9e88d322560785d8c9527f02b897804f74799347bcee0af73340bbbfdcd11dd337d443c39fff6554af3a7583e6e3ff9888d5136ab1ab2cf525a0eb067cbacb9b9a11b3a6bef1235dfebea11eaeff5a2e72f99347bcdcbe924bed067403818a5cdd6616c4ec91218695de4fada60eebe28bb53ad51531f9a92dc4ebb9217eb2d481406e28f04b5dded48c9869714c4d8489b1945e7f4828ff09a13e95dcfe6b42c4cc8d1b59ea50603719a8a879ed6d216ecf0f71ac7c04bd1c234fb937871bf92747b863523362e6365159ea6420371d3877059e0271bb33e216eb955e7e5828f76b433d2ada233127fe4c8898b99e94a54e07760b825ce1f2a6d5113b37ae42be853bbb63ba8af2fe1e9aa6fdeee38e492b236e9786382e774110a1007149b06b5cbeb43a62b71ebe528b65dd9fba63ba88b2ea8be103b5b2d7bdd51d935647ecde1162b9dc25c18442c445416f70f9d27888df91219e959fe13eee98aea19c2fa895bb4e8ba0ece48e49ab23767f5f8ba5746251d0b854f1575cbe341ee2a76f4f374d5814eb4eff14a07c7f88a647ff5cf07306c4efe610cf4e2c0b1e3706d1ef92418c605b16e2a765b3dc56e2f237ee982ea06cdba069b14fbdf8cbf5fea644ec349e228e18edc4c6206e6bb0fbb9bc697cc4f06921a675c7bb63968932ad8f8fd5ca58f753e4a3ff0c889fd6918c71edc4d6606e73d0c35dde3419e27875886b455b447566092dcaa29f2d6f1c95cd39d61d97c6470cdd7e129dd81cd46d0ffe6297374d8638de13b7d6e25aa79183ffc51db74894417bd65d382a93935b7db78038ba81629dd81e5c8b5bc68215b9d9e53c10cbeb426cebf47b7b695b8a716d0d61be6c541647ef83eeee8e4d93218e17d5e25ad9d2e59d844d9c1405f97e2858eeefd602e2784088aba32784df77c7cf13d7d46ffef802d879a83b3e4d8638c6f72bb7ba7c93b28993a23071551bcdfdcea19e33207e1a47af1180f5b836f931fec09d671eb896d63078cfe8daabd1f0e6addd79d2f88861ec15fa88cb37299b38290a737e289c6ce3f2a6d511bb5df18fb5588e43836cf43b711d77ceb670fe83f15db83234f914b673e74bab23767a1714637ab1cb3b299b38290a7372289ceceff2a666c44c7dbd4f47d31800893fb7223d8db5fe61e39c9b60a537fdabf91172f5df2910370dae8af17ca1cb3b299b38290aa36f8558c067b9bcc9235e07e2a65afc9c2ba15983ab7d10f507e458ccfc338c73e82dbfbaa0be0177ad8ade45dc16d21c6d8c3ad31cf6d2102fb76e642b7f4c6de2a428cc0ea17072a1cb9bd6449c346beebdb5b835792bee503b4eabc3340db9ad68251e359e8debd71c07c76c81d3f055b873d76994dff6d05382e6acc719a2d1bf415385efe6ae9dd6449c5c37eb7d5dde49d9c46950a03897fd5b2e5fba1df1b9172e80bacaea7173f4adb9d6305ad21e0e3d5abb63eaf492f095d8137789e7199d4b5d7afa43aecd27fe061a6ce4ce15e9bceb8773a9f7a26985a33a3da968cbebff5a3f3ead89f8c497c15a30b69597ec36711a1428ce559641ad6ddf0662a28554b508e86adfde157d181bc7d0f36f1a22fa7f4679c7f54fd0bb828ba1d1865f82be955dde265ae9a771455afeedee18b7a740fe017aff914f0535c4c32dbb77a5cb3b0d9b380d0ae5c6aee77b0010870da1c61d674eae44eb028cb5e433f9b43293f68e77cb8bcfc3bbb16a2f0f79344458ef22c6791aa8e80fa3fe28695af486eebc2521066e3bf5135cde69d8c4695028fd068c057d87cb5b0aeaaf47eab331ce637a456be5ff093670e75c09c7e87a7f0b77de367c0813afe6c331fab97309567b3710693c899e52f670e72d01757783ad5a7bb2b689d3a260f14db17ee3fdfac55509a8af06f068fdf6ff8d491bbc7e1a6cebce3b09cea1dfe0ea7b77d798c6a7f147ee5a93e01c0fc0fb46e79cd4c7f1641433d59cbaaa5b387e79dce2f24ecb264e8bc2b9f1ca334f58e83aeaa847703db2be0b1a901363b01af502b43e6496736a3f3efd3458ad0bcff93cfe0cad0f33e69c0fc51598e6278bc641fc39eee5ce3d24d4718f519deb2e7179a76513a745e18e0e8595335cdebea35e77c4a3f166e8b13dd67b35ff8a3760ee6b27700dfd16df07fa69a19e077d0b7f192a837e9fdf887742abce6a50d742fae9b98eba1ad59df959b818ad44ef0ad435aaf11313ff5cea03eaf542c47ab73ab5da264e8bc269459858e0eb5ddebea23e9afd78069ad6bb5f8d86d1ea8338f34cae21211e1a0ff10a8c3bffa14edd6267625031a53efa1919eb3af34fc43a9b380b0aa86f967a81d5bdb489cbdb27d441dd5a7f819586e936d1b795bac4f433618d3ef3b426e2a3a795fdf0264cfa13414f62afc3bdddb9fb843adc09712c46ebeb6ddac4595048373168a61d4c9789b26f8a57639ac7fc8f4223f1b26f7b0ac44d7f745f8c499f0af4d3464f69bdfd6940d9dd54f0f35dde59d8c45950c8c343a1a5d517178b42b91f84afd7ea310e0dcad11e6e3bb873a6c9114b8d523c0cee9178251a4bf10877ceaea3dc7a3f14ebd3fa527b367116147203c44921faf6eccdcf00caaa0930fa9d3eee683d0d83567fff03ddf9527b88b1a64a6bf8b08637bb7b11a92bf639ee5c5d457935702cfed4d467aaf5271a9b382b0aea7e061ce7f2760de5d41fb06b6ae56ea286a59d5a345573ae73f0d3da88b976517a04ae85bb3f912629f562911acae97ad35a7ffc179b382b0aab2ea75881ceef184419b5cc55d34abc15bdd4fc5fc8a5cf3b827bb13b34ae60b589559aafd2f997b094d1ad033997fd146de2ac28acdee4ba69a49d9d074ed9f43b53b3ee6299eb3e8c5e6ccf5522ee8d063e696ab2bb77158d81b8933bbe0b289b8673c711a4fa2ccde5e9c526b68102ab5fb65e0939cbe5ed02caa62ebe58de8aba634e453eea771cf7487fc8358066a52ec457ba63bb80b2bd2c9455ce7479db6013db40a1770c95905bb0aecbbf4c9469273435184d48d9cf1d97ba8b7bb62f9ac66ce8675c2b0b6ab48932e9e5b3ebf2dcd1e56f834d6c0b05bf2154440e7479978932c56d972b6a40839fcb3054dcbbdf47d388cdf7b96396893269819758ceb9be3bb3896da1f0c787cac89b5dde65a13c4d6befeb85d2c296da4ef3c13ddc0b4db3320f73c72c0be5b93c944fe6ba0fa44d6c0b85d7b8f9389c51ffbf99cbbf6894432f2b9b26a2bcc11d93fa877be966a98a86ad77e2bd0ee558ca67c526b6890aa87ba65e2939c5e55d34caa19964b16ca247ff7bb86352ff702fb782762876f7ba134f0194e394502eb9c2e56d934d6c1395d04294b1625a936ee9cb3d5186a6c5299eeff2a7fee29ebaa9b5b2f4d9aa944123fff4998865dbd3e56f934d6c1b1571a3b54e75791785ebef16ca53f91a8a5975a614dc538df06c5a1865e17b2bd6717d7531c7325debf2b6cd26b68dca687a67aca0567659da5300d7d668be5826c9854c078a7beb3e687299cbbf085c5bdffe6eb7a785743ddbc479a042d7870acae92eefbc71ddbbc0f5fbabcfdfae9b9ffa8f7bab4d4de38b36515b58ca6435ae7b7aad1c9585fd2cb189f340a5dc0b37ed6fbf91cb3f4f5cf3885a19ea5eeff2a7e1e01e6b9f0577ef9fe8f2cf13d7d45a92fa0cc4b22c6cac8c4d9c172aa6b5e762655fe0f2ce13d7743d13727f973f0d07f778ef70cf2b6f71f9e7896bbe2094416e7479e7c526ce0b95d3a20eb1c25acf6de2bdeba6c5b5f432488ffab11c1f76f9d3f070afdd92e9ea265cd80a425c6b63a8edc7722cb45bd226ce0b95d3c09b9b6b95adb4b2d5f138b8d621e1da95135dfe343cdc6bf7cd2b07bbfcf3c0b55cb7a43e1b0b5db3c026ce1315d4c298b1e21aafbd90a700aee3765a955cc2ab10dceba62ee00b5cfeb6711d7dfbbb390a47bafcf36413e7894a6ab7932fd42a5d7985cbdf26aea16bbbc7ae2fbafc69b8b8e79a991adb815ec8cd7db62ad7d0f2e7f1dafa4c2c7ca6ac4d9c372aba7fade2154dd1dccde56f0be7d7cebcf1baf23f5cfe345cdc736d90e2dac2835dfeb6707e3d7db89d980f70f9e7cd262e021576339f3e89b9fd15e4dce7d4ae5537f3be77a95fb8e78f096da0f22a97bf0d9c5b4fa06ec5a285f740546ce22250e9ade1166c789ecb3f2bceab17906eb105ad21dfd925a2d27c70cf3781fb26fe86cbdf06cefd9c702d51efc33d5dfe45b0898b42c54faa05a2a22ebaed5cfe5970ce07d6ae51778dcb9f868f7bff81d0162aadff14e59cda22ddcd483cd9e55f149bb828545e8f44ae4ff66a977f169cf3d9e11a955ead199fdac3bd3f2db485ca092eff2c38a7768e8ed7d15a144bdd3edf262e1201685ab1e508977f5a9cef9270feca2e2e7f1a3eeefdfd425ba85ce8f24f8bf33d2e9c5fd4e697bee2944d5c3402715e2d3015cd90dadce59f06e7725d8f5f737953396803df0c6d426e7279a7c1b9b4b7a476848ed7b8c8e55f349bb868046373b84911adfc25e63cba09ee29e3752e7f2a076de0f5a14d88d6836c65921ae7715f6eb7a2135b99dbc4652020c7d4025437f3cc28cea1edbbdcb95bdf6c31f50b6de0f1a14d54661e0fc039d4eedc17cf5c17fa9c844d5c16027365089468c8e44cfbbd737cd37250735b6f3df5036d6097d0262a33ad5bc9f17aebef9e6ab5047d67f628b489cb4260b45087b6748e41fb34eeec8e1907c7bead76aecacf903bfd148e36a09e288d0589ed63eac1391cab19a76eeabb96246bedbd561b6ce23211206df4e856ebb9d4e51f07c7ba71df1f77795379680b1a811adbc7d42f8839f6e2702ef905f672f997c9262e1b816aadcf9e6334e2d09d2bd7fd4fff89b6f0c6d0362a13bfa8e39867857354963ae0a7894dec0202f6d61040d1d0cd895ece90ffd0daf17527b9fca93cb485e786b65199688e08f9b52dbe1b5efcb72e7f17d8c42e2068eabad312dd31985a3ffd77dc310e79ffac766cdd435dfe541edac2c342dba8bcc4e577c87b4f7caf766ce5ebe8c44e588e4dec0a02b707f4db2906f5e3186bed7ef2b99e05d9c2e54fe5a12d6c19da46e54d2e7f44be3be263b5e32a6abb73dfdc631636b14b0860d3e3d958bfe1c9e7e61a7cd7e54de5529b086d443ee6f246e43b3f1c5799cbccd636d9c4ae21904dabf89ee6f2d791c74d397eafcb9bca459bb826b411f9a1cb5b479ea6094573dfd7af0d36b16b08a61eb19aa66e36f60cf06f4d8f767fe5f2a772a94d843652d9d4e517fecdcdef17b5d55e6c2f6713bb88806a90d06746018eecf44dd235d3d0e53fdae54fe5a24d3c39b491caee0df94f08f92a6aa3bdd95dca26761581d536cfae6740e3ad8f33f9dd0ac4b2f46998a95b68130f0a6da4f20493f738b831fe6a9b5bc5fc5d6613bb8c00ef04b799a26ec83121ef4b6aff5e77af7abe946813db8436527951c8a7496beec3af36b9533d6f1fd8c4ae23d01a2eec9657d234ce5f2f24c27f5f54fbb7ca2fb1f0e59753b7a94dc00de2f9f59474fe5b7b4aaa8dc53c6a8bf6a742d7d9c43e20e007c08d11d007fcb1a33c1faaa557e6b6e863ea37b58dd056e483a37f7b2cd4b6e2bfab0d2e6549ef36d8c4be20f0fa8bec1ec7f497fcd1f84e2dadf22177ae94d436425b11b521b525f774a0b6d7ead2758b6613fb841b70e2e846c49be39e0e64ea598569d8d436425ba9b8b6a436d7fbfd246d62df7023f424d0f4818fce72e748496d23b495266a6bbdfee6afd8c43ee286e89d807b31183dc31d9f92da46682b8eda586f7ff34736b1afb831ea1d705d8475b90d58b2681b0785b612a96df5f26d7f139bd867dc208d137083852a390d3859b48dfd425ba9539bea5d3fff6a6c62df71a33462b069d8b02607ad35ba2b958d3671187e346a2391da52af46f88dcb260e01374c73079a261089d66bcf4d410b471bd044b3d78cda84a336d49bb1fd93b28943c18dd3cd6d9a4a2c9fc3aeeed8347cdcfbfb402b4ebbb6216a3bbd98d5372d9b3834dc442d2ad2d44da8dd88d7984390868f7bfe2434f51aa9ad3cd71d3734367188b8a15a5e6ca597835aca7943776c1a0edd63b8392215b5913ddcb1436413878a1bab8546dd6ac3952fe161eed8d47fbab7a37beceebda86d342e0032443671e8b8c9da77c06d3e52d156e27773c7a6fed1bd1cdd5377af456de1d9eed8a1b38925e0866bd090db86aca21d5c9f8eceece39626a37b37ba87ba97ee1e8bdac0a006f74cc22696821bafaec2a665c32b37e0f7dcf1a9bb74cf46f7ceddd38aeefd60bbf8c661134b4323d02a2f2b0d21d654d057205f12769ceed1e85eb9e9bb15edda9b3d3fb08925a2416c8673e1567ca9686eb8de1f6ce0ce919647f764746fdc1a10154de1d500b04eedd0bb4c36b164340e7517baad9debbe0dad4330e841227da07b30ba17ba27ee5e55b4414ce776e75d369b583a1a8ad6877b266e836b4c956fe278acefce93e647311fc55ef7c0dd9b8ae67e9c845c07d2b089e976349a7b60a5eea38a3680d452d1ebb9f3a4f628c6a3582be6ee5ed45d8eaddd79d2ed6c625a138de821b879d4a856a245255f847bb8f3a4e929a6a3d8ba853ba32f607f779eb4269b98d646835a078fc767e11a5d9dde40ab8b697fe43882292976a3182a962bbdd5afe88fb43683c9c7fd31d9c4d48cc6a546f9287c02ae11465f863690dcd29d2fad4db11ac54cb173318df4d256f3f9f38fed846c621a0f0deee1704b493b1a6e7a19b4ec547623068ac928368ad14ac3b4ebaec781ee7c693c36314d8646f8605c3b6a94e3d014e4ab7034eeeace5902d51dda9453b1504c5cac1cc57a3f77ce34199b98a643a3dc135a44e2e7700dd7d16e33d7e164ece8ce3b24d4717b687d06adb4e376da69a2982ab67bbaf3a6e9d8c4341b1aa94615aa8f7ab5b1e8cee7a111891a9ebc2b7afbbb5665c7ced0b7fc6b71135c9d57a2182a969bb96ba4d9d8c4d41e1aee8e38135f856be0abd160a4f7e2a5d06fe42ddc75ba80b26d8e037106de839566e1ad44b152cc06ff44b46c3631b58fc6ac6fc37d703e561b61b81a4d617d37b498a57e3a68efbaddb089bb769bb8c6c6b83f0e851ee5cfc1bbb0d2421be3504c141bc528dfe62f884d4cf34503d71befc3470d7edcaeae71fd10eaa27c0bf453e2afa06f5375ab9d00bd78d4b51f017dd844ffad34fd9bf228af8ed1b1afc39bf171fc33dc35a7a5ba2b06ba76f68c2c814d4c8b45e3df06faf069adba7146baf595eaa63aaaaedbb858a4c5b28969b9f870e84df9d3a0dd6a579adeda752abbeaa0ba6cefea9a96cb26a66ee1c3b3030e867eefeb91f983586d0fc445525934204a653b052aeb0eae2ea95b6c62ea073e64ea6edc1bea32d4d6d66f83363bd1dc784d83d50218ee033b099d43e7ba05eac67b3b5e8e63a16be7e21a3d6613d330f0e154cfc346d05e89ea8fd742a89ad978088e82b6c316fdb7d2f46fcaa3bc5b43c7e61bf901b38929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b08929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a6944af0abdffa0f50331f92e214a57e0000000049454e44ae426082),
(15, '12-53646', 0x89504e470d0a1a0a0000000d49484452000001000000010008060000005c72a8660000000467414d410000b18f0bfc61050000290049444154785eeddd79dc345579e6f10404511601410583208b806322a384650c881a500222226e80022a11414565738b01c7046312d4c1510411c880a0801a9720a21351c495b88119f715351a11354e1c63c6fcaed0a5f5deef55cfd34b7577559dfb8fefe703e73d5575ce5da79faeaeb3fdd6af7ef5ab9452a16c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b08929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b089691876d876bbdfc646d80a3b63773c0487e0283c6344ffad34fd9bf228af8ed1b1bfedce9d86c126a67ee0c3b919f6c631380b6fc3e7f06dfc04ff1fbf9a91cea173e99c3ab7aea16be99abaf666ae6ca91f6c62ea163e643be0609c8cf3f1417c1fee03bb0c2a8bcaa4b2a98c2aeb0eae2ea95b6c625a2e3e3cdbe369b814df81fbd0f581caae3aa82edbbbbaa6e5b28969b1f8706c83a37111be01f7611a02d54d75545db771b1488b6513d37cd1f837c0e1d023f397e13e2cd3f825be84ebf02e5c86f3f0d73803cfc37178020ec2be23fa6fa5e9df94e74fa16374accea173e99c3ab7aee1ae3d0dd55d31502c3670b14af3651353fb68e07a23bfcfa8c1df06f78118d70ff061bc11a7e350ec8af5ddb5dba46b8caea56beada2a83caa232b9b28e4b31516c14a3ec7958109b98da4363de1167e2ab700d7f355fc305780af4d67d73779d2e50d946655459556695ddd569358a9562b6a3bb4e6a8f4d4cb3a1e1aa7bee78dc00d7c05752bd387b2aeeedcedf27d4613be80fc225b805aece2b510c15cbec6e9c039b98a64323dd1357e0e7708dd9f921aec289d8d59d7748a8a3061969f091e234c9cf06c554c7ece9ce9ba66313d3646894fbe15ab886eb68608d1e911f8c627fefaaeef8034cfa5e44b1decf9d334dc626a6f1d0080fc4f5a346b99a7fc73538027772e72b996202f5445c8d717b1a14fb03ddf9d2786c626a4683d3b7d661b811ae514637e1346cedce97d646ac340fe15468e8b18b69a47ba17b92bd0713b289696d34ae7571246e866b84753fc6abf14077ae343e62f880512c155317eb3add1bdda375ddb9d2da6c625a130d6a7f7c01aed1d5fd335e8c4ddd79d2f488e95df0228cf3e250f76a7f779eb4269b986e4723da1a978f1ad54ad475a749301bbaf3a4f628c6782ec6e952d4bdcb9f5e2bb089a5a3d1e871ff24e86dbd6b5895af435d5a7774e749f3a398e3e9586d8095eea1ee65fe2c306c62c968287be153708da9a2474ccd87bf833b475a1cdd033c099f87bb5715ddd3bddc394a66134b44e3d030564d7e5969118defe1c958c79d232d0ff744bd33ea625d69fab4eeadee716787532f9a4d2c0d0d42dfe62bbd5c521ffe39b88b3b3e7507f76813bc0a2b8d25d0bd3ec61d5f1a9b580a1a81de2c5f396a144d3e8a07b8e3537771cfee8fd5e662e8de17fd47dd2696801bafc52fbf326a088ec6e8ff317270494fe9de41ab11a97bd6dd63511bd8dd1d5f029b3874dcf067e3ff8d1a40a4df896fc016eed8d43fdccbbb42f30d9adeefa82d3cdb1d3b743671a8b8c99be2ada39bee68d8eedeeed8d47fbab7a37beceebda86d143588cb260e1137760facb4408556b6b9b33b360d07f758938e3413d3b501511bd9c31d3b44367168b8a11a39f68bd10d8efe054f76c7a5e1e29e6b3314dd7bd726d4569eeb8e1b1a9b3814dc448d16d32212ee268b1e0707bf0847f2b8f7bbe0b3a3b6e0a8ed0c7a94a74d1c026e9cbaf83e30ba91ce85c847fec2d106f493402f085d1b11b5a1c17615dac4bee386693ef967463730fa198e76c7a572d126348df8a7a33612a92d6de58eeb3b9bd867dca89dd0f4b24ff3c5efeb8e4b89b6a1f50a9bbe38d4a67672c7f5994dec2b6e9006f734ed99f7f7c8a1bc6945b411ed88fcde519b89d4b6063568c826f61137e600343dc20dfe654e6a0f6d653dbc69d47622b5b103dc717d6413fb861ba259604ddd7caf41cede4b13a1cd6818b12615b936a5b676843bae6f6c629f7023b49e7ed310cf17bb63521a176de8f9a14d55d4e64e74c7f4894dec0b6e80bef9dd875f53419fea8e496952b4a563f16fa3b655a7b6d7eb27019bd807045ebff9dd63ffffc523dd31294d8b3675f0a86dc5f6a636d8db770236b1eb08b8def6bb177eb7e2bfb963529a95dad6a88dc576a7b6d8cbde019bd865045afdfcaeab4f7f9df3c39fe68a36a619851a4c16db9fda64efc609d8c4ae22c01ae1e706f9e8f7d9c1ee9894da465b3b68d4e6623b54dbecd588419bd845045663fb9b46691deb8e49695e68735a1cd6bd80561bedcd80339bd8350454b3fa9a26f63cdf1d93d2bcd1f64e096db1a2b6da8b816736b16b0866d394de57b9fc292d0a6df02f439bac5ce1f2778d4dec1202a9c53c5c8035543317ec6c406cd6c176f843ec87c3713a5e86a7605fe4b6593322861a3178315c1bedfca22236b12b08a096f1727dfd9aacb19e3ba654c4430df1c1f89fd0b6daff8a1837e736bc13cf8376e2cd61d3132266da9de8dd88b155dbedf4f26236b10b089c16f0746ffcf5926523774c8988853ef88fc1a71163358d1fe1ed780eb4b67e3e658d8138dd199f448ca7da7067171ab5895d40d0dceabd1a70b1b3cb5f1ae2a00ffee3a06ffb18a736697f04dd8be3b1a52b4bba1df1d91e7aa28a317cabcbdf053671d90898d6ed8f4194235dfed21007fdb67f5f2d2e8ba2beefaba12eb04d5cd94a475c1e0b17bb4eee3b60139789406998afdbb4e37c97bf24c440dffada8ebc69dd8345d23b8637637fe4cf841ae2f15ac478a94d776eb8b04d5c1602a4c13e6ebb2eaddc7a27774c29a8bfbef5df3f8ac76ad4d8d417fd2778220e81be9976c3bda08954fa8dff7a28b64dd3a9c7a53dfa5f84ec550071d0b815b7c5bcda76a70609d9c46521386ea34eadddbe8bcb5f02eaae6ffd1330ceb7feb77012267a494afe2da06e42f520acb6cffe4a340dfb1d78248aee4da0fef781bb6757bafccb62139781c0688bee182c39cae52f0175d792d557d562d1e4ebd02698ebbbf34c8af3dc1d4fc0b9f812dc3557f3093cd09dbf14d45feb55b8d874666b729bb868046473b8fdf92f70f94b40ddb5a1e56adb5bebd15d4b9ecdb55b94f3ab3bf02ce851df95a3c9bfe31c14bb182b75d746b3312e6aeb9bbbfc8b6613178d609c570b4e45bbf614f9bb9f7aab3be90ba33834f922f671c7cf13d7dc135a2b6fa52db7a3efe289ee7c4347bdf514e736243dcfe55f349bb84804622fc49750faff2277e9a5de7a4977cb280e8e7e676bfcf952ff38727dbde8d2661ad7c195d3d14bc73bb8f30d1975d61a02ae8defe5f22f924d5c1402b02edcdbd222bbfca8f766d0e625311e152d3ad1b9454f2893f6d83b1b1a34e4ca5df71e6cecce3364d4d96d3fa6b6bfaecbbf28367151a8bcde58c7a0e8d1f2ae2eff9051e70df0c1510c1c3df2efe08eed0acab7315e0d3da5b83a54346cb9a82e43eaab773aee67d3492effa2d8c445a0e25be327b540549ee6f20f1df55e6917e38f620b775c1751564d2afaf8a8ec4df4a4d38917618b427dd55313e3a0cfc0d2fe18dac445a0d297d78250d15befe2469551e7a7d66210f56a85990a65d674e467c1cde6ace80f5b312f7aa9abc674b89e9dcb5dfe45b089f34685357c3406418f8df777f9878c3adf136e0289a87fbfd78fca945fcb69af3435f9b5eeb8a1a2beea52753f91f677f9e7cd26ce1315d58b3fd7c555e4ea3ed45b73f1632c44bf17073102927a3c0c1ad1e9ea298f72c70d15f5755b8ee933b1f0178236719ea8a4ba8e62e5bf83e266975167178bcaa1ee98bea23e5a53bfe949477fec8a7929485d3781da7c8cc3c267bbdac479a182fa0de4bab906b1d1e224a8b35691d1d8fd180bb9d41dd377d44b83889ade095ced8e192aeaeb8609ebb3b1d0776036715ea8dc61b5ca5634f9a4c4177f4df3c6356a6eb06fc7a9db0b6a758df674c70c11756dfa323ccce59f179b382f54eec650597992cb3b74d4fb43210e95c35dfea1a07eea1d681aefd0d99573e681faba9f8037babcf36213e7818a1d182a2a9a5c52e2d050f593c758885e040dfe69883a6e0bb7d1a6260f15b3e41b75d50bf12f8fea5e77a0cb3f0f36711ea8d4f5a192f2749777e8a8f745210e9567bafc43445d35d5d8c5e05c977fa8a8af1b1c74bdcb3b0f36b16d5448ebd2c74a6ac24b2f764f6993ea0cd725a637e4c5ac764c5d77469c2023df71f9878afaae876fd6ea5fd9cfe56f9b4d6c1b95b936544e3abf69c23c506ff589c758c8d92eff9051e7a63110bfebf20f15f57d66a8bf5cebf2b6cd26b6898aa8eb27564e0b226ce8f20f1df57e692d0e750f76f9878c3a6b3f03178b935dfea1a2be9a08f6bd5afd2b73ef15b1896da2126e92cb8b5cde1250f74b432c448b786ee0f20f1975deb21683ba6b5cfe21a3cea78618c8dcf717b4896da1029adffef35a85e4c7287989283719e44b2e6f09a8fb3f8658c8f75cde21a3ce1b21aea7a0cfce662e7f5b6c625b28bc7693a957485eedf29682fa6ba04f8cc9fb5dde125077ad1214e321c56dff469d5f116220c7bbbc6db1896da1f0eedbaed89562a9bbdef8ba37df17b9fc25a0eeda9f20c6437673f9878c3adf2fc4406e7079db6213db40c1770c15919b5cde52507f2d101963227feef29780ba3f3ec4a2f218977fe8a8f73f8438c88e2e6f1b6c621b28f499a112729acb5b0aeaaf1d64634ce4652e7f09a8fb3e211695e35cfea1a3deee89e84c97b70d3671561458131de21af21ae659f4d651d47fc35a3ceafec2e52f0175d70e3a2e2647bbfc4347bdb5298b3661adc7429fa5b90c11b789b3a2b0eeaf7a715d3b1131d0a299312e52dc20a00a7577bf7ba5c87d0484babf3bc442e6b207844d9c1585754b201737e73f22065a0822c6455ee3f29780ba6ba110179322df01087577ef45e6b254be4d9c0505d5a8a6b8f28b563e2d7a775f2106dafdb81e97caeb5dfe125077374b541ee9f29780baeb33a4f132f578e833d5fa60319b380b0aa95d66eb059762f7f8ab230e9a0b1f7fdfc9852e7f09a87b532fc0c35dfe52507fb7a760eb6b45d8c4595048f7f85fdc38f726c4e2db2136f2772e6f09a8fb1f8758541ee2f29782faef1be221adff0cb089b3a0907181030d6f2c6ec9af26c4e263b5d8546e76794b40dd4f09b1a83cc8e52f05f5574f5a1c1afc1597771636715a14709b5060b9cae52d15f1785b888ffcd4e52d0175ffef2116959d5cfe921083ab424c645b97775a36715a14eee8505839d1e52d15f1d07efe314652dc7e8842bddd6c512d17b68ecb5f126270622d2695635dde69d9c4695138b7d4d5ae2e6fa988c70b437c2a0f70f9878e7a6bf7a3188b4fbabca5210ebb86b8c8252eefb46ce2b428dc3742618b5ade691cc4e49810a3caa35dfe21a3ce770b31a814db2b12118bb881c82d2edfb46ce23428d8f6a1a032c80d2e66414cdcbe88f21c977fc8a8b3f60d74b1286a45a095100bb7804c6b5bc6d9c4695028b7bae9535dde921193fb8618555ee9f20f19757613c6e40097bf44c4c2ed1c7d82cb3b0d9b380d0ae5fe52dddbe52d1931392ec4a8b2b42da297853aff5d8841e51e2e7f8988c5bd436ce44a97771a36711a142afe56f99acb573262a20541dc4b2f39c71d3364d4f933210695fbbafca5221e5f0bf1d166aaad8cadb18993a2303bd40a57c9e1bf01313936c4a8a24541f772c70c1975bea41683ba97b8fca5221e1784f8482b7f246de2a4288c7b99f31497b764c4a46947a0935cfea1a3de3be197b538543ee5f2978a78b82f8e56664bdac44951989343e1646f97b764c4e413214695ed5cfe125077b72af0cf5cde52118fbd427ce4852eefa46ce2a4288c9b0034d82daea7454c7e1a62244a2b76ae0475bfbc168bbae2f64968422cb4bc7e8ccfc52eefa46ce2a4284cdceef9072e5fe9888bd645a8c7493ee2f29682faff658847652b97bf54c4e39f427c5a693736715214e6fba1701f76f94a475ce2484959d84eb05d44fddd84975f603d97bf54c4e3ba5a7ce456976f5236711214c43d9ebcd1e52d1d71f9548893dce6f29682fa7f3ec4438a9d1edd84989c1762245bbabc93b08993a0107b8742c9e92e6fe9884bd3c097df71f9878e7adf01fab68ff1788bcb5f3262f2bc10239979cd049b38090ae126b71ceaf2968eb89c11e25439d0e51f3aeabd4b8843e50c97bf64c4e48f428c64e6ae769b38090a71562894e4146083b83c3cc4a972aacb3f74d4fbd1210e95c7bafc2523266eb0ddccfb49d8c4495088b8c28d0676aceff2968eb86c0ab7376091b326a977d3da0839143820265a5036eeb4fd7697771236711214e273a150c56e753d0ee2e35e7a7d0fc58d05a0ceefacc5a0923d000d884bfcac7dcee59b844d9c048588abdc5ee7f2a5db119fa625c18ada0d97fa6aa3542dfd15e370a3cb9ffe3366d784587ddbe59b844d9c048588835bdee5f2a5db119f478578555ee5f20f15f53d2ad4bf52ec4ec9ab213671ccc44f5cbe49d8c47151002d5d1c7fd35ee6f2a6db111fed0ee426c068f3d43ddd3143433db501e60f46f58e720f8906c4e6e2102bb599997e3adac47171f18d6a85a99ce7f2a6df20466f0f31ab14f1f84b3d9ba601eb5d48fefe6f406cdccfc78d5cde71d9c47171f1ad4261e4af5ddef41bc4485b62bb013032e83101d46f5bb8272079b23b26dd8ef8bc3cc44b669a336113c7c5c5770e85911cc43106e27476885be5752eff50503fb7d6bd5c8fdc416a05c4e7c5b57855767679c76513c7c5c5770f8591e7b9bc694dc4497328dc5bf099bb76ba8cfab9c93fb2bbcb9f7e83189d14623673dc6ce2b8b8f8434261e4389737ad8d58bd3fc44ef452753397bfefa897dbef4ebeeaf2a7351127b742f04c9ba8dac47171f1434261e4092e6f5a1bb17a49885de52097bfefa8d76ea19e95735dfeb426e2f4b8103739c4e51d974d1c1717777db9836cbcf340acf60bb1abbcdce5ef3beae566b4492bebdb0d1d717213828e7279c76513c7c5c59f110a23fbbabc696dc46a036845e018c38fbafc7d47bde2ca51a21e8141fee4691b71dab716b7ca335cde71d9c471e9e2a130927f002640bcdc87425adbfea90ba8cfef86fa5506f9c76e1e8855e7fe00b89f0007bbbcc9235ecf0af1ab9cedf2f715f53937d4af52dc9e88d322560785d8c9527f02b897804f74799347bcee0af73340bbbfdcd11dd337d443c39fff6554af3a7583e6e3ff9888d5136ab1ab2cf525a0eb067cbacb9b9a11b3a6bef1235dfebea11eaeff5a2e72f99347bcdcbe924bed067403818a5cdd6616c4ec91218695de4fada60eebe28bb53ad51531f9a92dc4ebb9217eb2d481406e28f04b5dded48c9869714c4d8489b1945e7f4828ff09a13e95dcfe6b42c4cc8d1b59ea50603719a8a879ed6d216ecf0f71ac7c04bd1c234fb937871bf92747b863523362e6365159ea6420371d3877059e0271bb33e216eb955e7e5828f76b433d2ada233127fe4c8898b99e94a54e07760b825ce1f2a6d5113b37ae42be853bbb63ba8af2fe1e9aa6fdeee38e492b236e9786382e774110a1007149b06b5cbeb43a62b71ebe528b65dd9fba63ba88b2ea8be103b5b2d7bdd51d935647ecde1162b9dc25c18442c445416f70f9d27888df91219e959fe13eee98aea19c2fa895bb4e8ba0ece48e49ab23767f5f8ba5746251d0b854f1575cbe341ee2a76f4f374d5814eb4eff14a07c7f88a647ff5cf07306c4efe610cf4e2c0b1e3706d1ef92418c605b16e2a765b3dc56e2f237ee982ea06cdba069b14fbdf8cbf5fea644ec349e228e18edc4c6206e6bb0fbb9bc697cc4f06921a675c7bb63968932ad8f8fd5ca58f753e4a3ff0c889fd6918c71edc4d6606e73d0c35dde3419e27875886b455b447566092dcaa29f2d6f1c95cd39d61d97c6470cdd7e129dd81cd46d0ffe6297374d8638de13b7d6e25aa79183ffc51db74894417bd65d382a93935b7db78038ba81629dd81e5c8b5bc68215b9d9e53c10cbeb426cebf47b7b695b8a716d0d61be6c541647ef83eeee8e4d93218e17d5e25ad9d2e59d844d9c1405f97e2858eeefd602e2784088aba32784df77c7cf13d7d46ffef802d879a83b3e4d8638c6f72bb7ba7c93b28993a23071551bcdfdcea19e33207e1a47af1180f5b836f931fec09d671eb896d63078cfe8daabd1f0e6addd79d2f88861ec15fa88cb37299b38290a737e289c6ce3f2a6d511bb5df18fb5588e43836cf43b711d77ceb670fe83f15db83234f914b673e74bab23767a1714637ab1cb3b299b38290a7372289ceceff2a666c44c7dbd4f47d31800893fb7223d8db5fe61e39c9b60a537fdabf91172f5df2910370dae8af17ca1cb3b299b38290aa36f8558c067b9bcc9235e07e2a65afc9c2ba15983ab7d10f507e458ccfc338c73e82dbfbaa0be0177ad8ade45dc16d21c6d8c3ad31cf6d2102fb76e642b7f4c6de2a428cc0ea17072a1cb9bd6449c346beebdb5b835792bee503b4eabc3340db9ad68251e359e8debd71c07c76c81d3f055b873d76994dff6d05382e6acc719a2d1bf415385efe6ae9dd6449c5c37eb7d5dde49d9c46950a03897fd5b2e5fba1df1b9172e80bacaea7173f4adb9d6305ad21e0e3d5abb63eaf492f095d8137789e7199d4b5d7afa43aecd27fe061a6ce4ce15e9bceb8773a9f7a26985a33a3da968cbebff5a3f3ead89f8c497c15a30b69597ec36711a1428ce559641ad6ddf0662a28554b508e86adfde157d181bc7d0f36f1a22fa7f4679c7f54fd0bb828ba1d1865f82be955dde265ae9a771455afeedee18b7a740fe017aff914f0535c4c32dbb77a5cb3b0d9b380d0ae5c6aee77b0010870da1c61d674eae44eb028cb5e433f9b43293f68e77cb8bcfc3bbb16a2f0f79344458ef22c6791aa8e80fa3fe28695af486eebc2521066e3bf5135cde69d8c4695028fd068c057d87cb5b0aeaaf47eab331ce637a456be5ff093670e75c09c7e87a7f0b77de367c0813afe6c331fab97309567b3710693c899e52f670e72d01757783ad5a7bb2b689d3a260f14db17ee3fdfac55509a8af06f068fdf6ff8d491bbc7e1a6cebce3b09cea1dfe0ea7b77d798c6a7f147ee5a93e01c0fc0fb46e79cd4c7f1641433d59cbaaa5b387e79dce2f24ecb264e8bc2b9f1ca334f58e83aeaa847703db2be0b1a901363b01af502b43e6496736a3f3efd3458ad0bcff93cfe0cad0f33e69c0fc51598e6278bc641fc39eee5ce3d24d4718f519deb2e7179a76513a745e18e0e8595335cdebea35e77c4a3f166e8b13dd67b35ff8a3760ee6b27700dfd16df07fa69a19e077d0b7f192a837e9fdf887742abce6a50d742fae9b98eba1ad59df959b818ad44ef0ad435aaf11313ff5cea03eaf542c47ab73ab5da264e8bc269459858e0eb5ddebea23e9afd78069ad6bb5f8d86d1ea8338f34cae21211e1a0ff10a8c3bffa14edd6267625031a53efa1919eb3af34fc43a9b380b0aa86f967a81d5bdb489cbdb27d441dd5a7f819586e936d1b795bac4f433618d3ef3b426e2a3a795fdf0264cfa13414f62afc3bdddb9fb843adc09712c46ebeb6ddac4595048373168a61d4c9789b26f8a57639ac7fc8f4223f1b26f7b0ac44d7f745f8c499f0af4d3464f69bdfd6940d9dd54f0f35dde59d8c45950c8c343a1a5d517178b42b91f84afd7ea310e0dcad11e6e3bb873a6c9114b8d523c0cee9178251a4bf10877ceaea3dc7a3f14ebd3fa527b367116147203c44921faf6eccdcf00caaa0930fa9d3eee683d0d83567fff03ddf9527b88b1a64a6bf8b08637bb7b11a92bf639ee5c5d457935702cfed4d467aaf5271a9b382b0aea7e061ce7f2760de5d41fb06b6ae56ea286a59d5a345573ae73f0d3da88b976517a04ae85bb3f912629f562911acae97ad35a7ffc179b382b0aab2ea75881ceef184419b5cc55d34abc15bdd4fc5fc8a5cf3b827bb13b34ae60b589559aafd2f997b094d1ad033997fd146de2ac28acdee4ba69a49d9d074ed9f43b53b3ee6299eb3e8c5e6ccf5522ee8d063e696ab2bb77158d81b8933bbe0b289b8673c711a4fa2ccde5e9c526b68102ab5fb65e0939cbe5ed02caa62ebe58de8aba634e453eea771cf7487fc8358066a52ec457ba63bb80b2bd2c9455ce7479db6013db40a1770c95905bb0aecbbf4c9469273435184d48d9cf1d97ba8b7bb62f9ac66ce8675c2b0b6ab48932e9e5b3ebf2dcd1e56f834d6c0b05bf2154440e7479978932c56d972b6a40839fcb3054dcbbdf47d388cdf7b96396893269819758ceb9be3bb3896da1f0c787cac89b5dde65a13c4d6befeb85d2c296da4ef3c13ddc0b4db3320f73c72c0be5b93c944fe6ba0fa44d6c0b85d7b8f9389c51ffbf99cbbf6894432f2b9b26a2bcc11d93fa877be966a98a86ad77e2bd0ee558ca67c526b6890aa87ba65e2939c5e55d34caa19964b16ca247ff7bb86352ff702fb782762876f7ba134f0194e394502eb9c2e56d934d6c1395d04294b1625a936ee9cb3d5186a6c5299eeff2a7fee29ebaa9b5b2f4d9aa944123fff4998865dbd3e56f934d6c1b1571a3b54e75791785ebef16ca53f91a8a5975a614dc538df06c5a1865e17b2bd6717d7531c7325debf2b6cd26b68dca687a67aca0567659da5300d7d668be5826c9854c078a7beb3e687299cbbf085c5bdffe6eb7a785743ddbc479a042d7870acae92eefbc71ddbbc0f5fbabcfdfae9b9ffa8f7bab4d4de38b36515b58ca6435ae7b7aad1c9585fd2cb189f340a5dc0b37ed6fbf91cb3f4f5cf3885a19ea5eeff2a7e1e01e6b9f0577ef9fe8f2cf13d7d45a92fa0cc4b22c6cac8c4d9c172aa6b5e762655fe0f2ce13d7743d13727f973f0d07f778ef70cf2b6f71f9e7896bbe2094416e7479e7c526ce0b95d3a20eb1c25acf6de2bdeba6c5b5f432488ffab11c1f76f9d3f070afdd92e9ea265cd80a425c6b63a8edc7722cb45bd226ce0b95d3c09b9b6b95adb4b2d5f138b8d621e1da95135dfe343cdc6bf7cd2b07bbfcf3c0b55cb7a43e1b0b5db3c026ce1315d4c298b1e21aafbd90a700aee3765a955cc2ab10dceba62ee00b5cfeb6711d7dfbbb390a47bafcf36413e7894a6ab7932fd42a5d7985cbdf26aea16bbbc7ae2fbafc69b8b8e79a991adb815ec8cd7db62ad7d0f2e7f1dafa4c2c7ca6ac4d9c372aba7fade2154dd1dccde56f0be7d7cebcf1baf23f5cfe345cdc736d90e2dac2835dfeb6707e3d7db89d980f70f9e7cd262e021576339f3e89b9fd15e4dce7d4ae5537f3be77a95fb8e78f096da0f22a97bf0d9c5b4fa06ec5a285f740546ce22250e9ade1166c789ecb3f2bceab17906eb105ad21dfd925a2d27c70cf3781fb26fe86cbdf06cefd9c702d51efc33d5dfe45b0898b42c54faa05a2a22ebaed5cfe5970ce07d6ae51778dcb9f868f7bff81d0162aadff14e59cda22ddcd483cd9e55f149bb828545e8f44ae4ff66a977f169cf3d9e11a955ead199fdac3bd3f2db485ca092eff2c38a7768e8ed7d15a144bdd3edf262e1201685ab1e508977f5a9cef9270feca2e2e7f1a3eeefdfd425ba85ce8f24f8bf33d2e9c5fd4e697bee2944d5c3402715e2d3015cd90dadce59f06e7725d8f5f737953396803df0c6d426e7279a7c1b9b4b7a476848ed7b8c8e55f349bb868046373b84911adfc25e63cba09ee29e3752e7f2a076de0f5a14d88d6836c65921ae7715f6eb7a2135b99dbc4652020c7d4025437f3cc28cea1edbbdcb95bdf6c31f50b6de0f1a14d54661e0fc039d4eedc17cf5c17fa9c844d5c16027365089468c8e44cfbbd737cd37250735b6f3df5036d6097d0262a33ad5bc9f17aebef9e6ab5047d67f628b489cb4260b45087b6748e41fb34eeec8e1907c7bead76aecacf903bfd148e36a09e288d0589ed63eac1391cab19a76eeabb96246bedbd561b6ce23211206df4e856ebb9d4e51f07c7ba71df1f77795379680b1a811adbc7d42f8839f6e2702ef905f672f997c9262e1b816aadcf9e6334e2d09d2bd7fd4fff89b6f0c6d0362a13bfa8e39867857354963ae0a7894dec0202f6d61040d1d0cd895ece90ffd0daf17527b9fca93cb485e786b65199688e08f9b52dbe1b5efcb72e7f17d8c42e2068eabad312dd31985a3ffd77dc310e79ffac766cdd435dfe541edac2c342dba8bcc4e577c87b4f7caf766ce5ebe8c44e588e4dec0a02b707f4db2906f5e3186bed7ef2b99e05d9c2e54fe5a12d6c19da46e54d2e7f44be3be263b5e32a6abb73dfdc631636b14b0860d3e3d958bfe1c9e7e61a7cd7e54de5529b086d443ee6f246e43b3f1c5799cbccd636d9c4ae21904dabf89ee6f2d791c74d397eafcb9bca459bb826b411f9a1cb5b479ea6094573dfd7af0d36b16b08a61eb19aa66e36f60cf06f4d8f767fe5f2a772a94d843652d9d4e517fecdcdef17b5d55e6c2f6713bb88806a90d06746018eecf44dd235d3d0e53fdae54fe5a24d3c39b491caee0df94f08f92a6aa3bdd95dca26761581d536cfae6740e3ad8f33f9dd0ac4b2f46998a95b68130f0a6da4f20493f738b831fe6a9b5bc5fc5d6613bb8c00ef04b799a26ec83121ef4b6aff5e77af7abe946813db8436527951c8a7496beec3af36b9533d6f1fd8c4ae23d01a2eec9657d234ce5f2f24c27f5f54fbb7ca2fb1f0e59753b7a94dc00de2f9f59474fe5b7b4aaa8dc53c6a8bf6a742d7d9c43e20e007c08d11d007fcb1a33c1faaa557e6b6e863ea37b58dd056e483a37f7b2cd4b6e2bfab0d2e6549ef36d8c4be20f0fa8bec1ec7f497fcd1f84e2dadf22177ae94d436425b11b521b525f774a0b6d7ead2758b6613fb841b70e2e846c49be39e0e64ea598569d8d436425ba9b8b6a436d7fbfd246d62df7023f424d0f4818fce72e748496d23b495266a6bbdfee6afd8c43ee286e89d807b31183dc31d9f92da46682b8eda586f7ff34736b1afb831ea1d705d8475b90d58b2681b0785b612a96df5f26d7f139bd867dc208d137083852a390d3859b48dfd425ba9539bea5d3fff6a6c62df71a33462b069d8b02607ad35ba2b958d3671187e346a2391da52af46f88dcb260e01374c73079a261089d66bcf4d410b471bd044b3d78cda84a336d49bb1fd93b28943c18dd3cd6d9a4a2c9fc3aeeed8347cdcfbfb402b4ebbb6216a3bbd98d5372d9b3834dc442d2ad2d44da8dd88d7984390868f7bfe2434f51aa9ad3cd71d3734367188b8a15a5e6ca597835aca7943776c1a0edd63b8392215b5913ddcb1436413878a1bab8546dd6ac3952fe161eed8d47fbab7a37beceebda86d342e0032443671e8b8c9da77c06d3e52d156e27773c7a6fed1bd1cdd5377af456de1d9eed8a1b38925e0866bd090db86aca21d5c9f8eceece39626a37b37ba87ba97ee1e8bdac0a006f74cc22696821bafaec2a665c32b37e0f7dcf1a9bb74cf46f7ceddd38aeefd60bbf8c661134b4323d02a2f2b0d21d654d057205f12769ceed1e85eb9e9bb15edda9b3d3fb08925a2416c8673e1567ca9686eb8de1f6ce0ce919647f764746fdc1a10154de1d500b04eedd0bb4c36b164340e7517baad9debbe0dad4330e841227da07b30ba17ba27ee5e55b4414ce776e75d369b583a1a8ad6877b266e836b4c956fe278acefce93e647311fc55ef7c0dd9b8ae67e9c845c07d2b089e976349a7b60a5eea38a3680d452d1ebb9f3a4f628c6a3582be6ee5ed45d8eaddd79d2ed6c625a138de821b879d4a856a245255f847bb8f3a4e929a6a3d8ba853ba32f607f779eb4269b98d646835a078fc767e11a5d9dde40ab8b697fe43882292976a3182a962bbdd5afe88fb43683c9c7fd31d9c4d48cc6a546f9287c02ae11465f863690dcd29d2fad4db11ac54cb173318df4d256f3f9f38fed846c621a0f0deee1704b493b1a6e7a19b4ec547623068ac928368ad14ac3b4ebaec781ee7c693c36314d8646f8605c3b6a94e3d014e4ab7034eeeace5902d51dda9453b1504c5cac1cc57a3f77ce34199b98a643a3dc135a44e2e7700dd7d16e33d7e164ece8ce3b24d4717b687d06adb4e376da69a2982ab67bbaf3a6e9d8c4341b1aa94615aa8f7ab5b1e8cee7a111891a9ebc2b7afbbb5665c7ced0b7fc6b71135c9d57a2182a969bb96ba4d9d8c4d41e1aee8e38135f856be0abd160a4f7e2a5d06fe42ddc75ba80b26d8e037106de839566e1ad44b152cc06ff44b46c3631b58fc6ac6fc37d703e561b61b81a4d617d37b498a57e3a68efbaddb089bb769bb8c6c6b83f0e851ee5cfc1bbb0d2421be3504c141bc528dfe62f884d4cf34503d71befc3470d7edcaeae71fd10eaa27c0bf453e2afa06f5375ab9d00bd78d4b51f017dd844ffad34fd9bf228af8ed1b1afc39bf171fc33dc35a7a5ba2b06ba76f68c2c814d4c8b45e3df06faf069adba7146baf595eaa63aaaaedbb858a4c5b28969b9f870e84df9d3a0dd6a579adeda752abbeaa0ba6cefea9a96cb26a66ee1c3b3030e867eefeb91f983586d0fc445525934204a653b052aeb0eae2ea95b6c62ea073e64ea6edc1bea32d4d6d66f83363bd1dc784d83d50218ee033b099d43e7ba05eac67b3b5e8e63a16be7e21a3d6613d330f0e154cfc346d05e89ea8fd742a89ad978088e82b6c316fdb7d2f46fcaa3bc5b43c7e61bf901b38929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b08929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a6944af0abdffa0f50331f92e214a57e0000000049454e44ae426082);
INSERT INTO `timages` (`ID`, `EmployeeID`, `ProfilePicture`) VALUES
(16, 'sample', 0x89504e470d0a1a0a0000000d49484452000001000000010008060000005c72a8660000000467414d410000b18f0bfc61050000290049444154785eeddd79dc345579e6f10404511601410583208b806322a384650c881a500222226e80022a11414565738b01c7046312d4c1510411c880a0801a9720a21351c495b88119f715351a11354e1c63c6fcaed0a5f5deef55cfd34b7577559dfb8fefe703e73d5575ce5da79faeaeb3fdd6af7ef5ab9452a16c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b08929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b089691876d876bbdfc646d80a3b63773c0487e0283c6344ffad34fd9bf228af8ed1b1bfedce9d86c126a67ee0c3b919f6c631380b6fc3e7f06dfc04ff1fbf9a91cea173e99c3ab7aea16be99abaf666ae6ca91f6c62ea163e643be0609c8cf3f1417c1fee03bb0c2a8bcaa4b2a98c2aeb0eae2ea95b6c625a2e3e3cdbe369b814df81fbd0f581caae3aa82edbbbbaa6e5b28969b1f8706c83a37111be01f7611a02d54d75545db771b1488b6513d37cd1f837c0e1d023f397e13e2cd3f825be84ebf02e5c86f3f0d73803cfc37178020ec2be23fa6fa5e9df94e74fa16374accea173e99c3ab7aee1ae3d0dd55d31502c3670b14af3651353fb68e07a23bfcfa8c1df06f78118d70ff061bc11a7e350ec8af5ddb5dba46b8caea56beada2a83caa232b9b28e4b31516c14a3ec7958109b98da4363de1167e2ab700d7f355fc305780af4d67d73779d2e50d946655459556695ddd569358a9562b6a3bb4e6a8f4d4cb3a1e1aa7bee78dc00d7c05752bd387b2aeeedcedf27d4613be80fc225b805aece2b510c15cbec6e9c039b98a64323dd1357e0e7708dd9f921aec289d8d59d7748a8a3061969f091e234c9cf06c554c7ece9ce9ba66313d3646894fbe15ab886eb68608d1e911f8c627fefaaeef8034cfa5e44b1decf9d334dc626a6f1d0080fc4f5a346b99a7fc73538027772e72b996202f5445c8d717b1a14fb03ddf9d2786c626a4683d3b7d661b811ae514637e1346cedce97d646ac340fe15468e8b18b69a47ba17b92bd0713b289696d34ae7571246e866b84753fc6abf14077ae343e62f880512c155317eb3add1bdda375ddb9d2da6c625a130d6a7f7c01aed1d5fd335e8c4ddd79d2f488e95df0228cf3e250f76a7f779eb4269b986e4723da1a978f1ad54ad475a749301bbaf3a4f628c6782ec6e952d4bdcb9f5e2bb089a5a3d1e871ff24e86dbd6b5895af435d5a7774e749f3a398e3e9586d8095eea1ee65fe2c306c62c968287be153708da9a2474ccd87bf833b475a1cdd033c099f87bb5715ddd3bddc394a66134b44e3d030564d7e5969118defe1c958c79d232d0ff744bd33ea625d69fab4eeadee716787532f9a4d2c0d0d42dfe62bbd5c521ffe39b88b3b3e7507f76813bc0a2b8d25d0bd3ec61d5f1a9b580a1a81de2c5f396a144d3e8a07b8e3537771cfee8fd5e662e8de17fd47dd2696801bafc52fbf326a088ec6e8ff317270494fe9de41ab11a97bd6dd63511bd8dd1d5f029b3874dcf067e3ff8d1a40a4df896fc016eed8d43fdccbbb42f30d9adeefa82d3cdb1d3b743671a8b8c99be2ada39bee68d8eedeeed8d47fbab7a37beceebda86d143588cb260e1137760facb4408556b6b9b33b360d07f758938e3413d3b501511bd9c31d3b44367168b8a11a39f68bd10d8efe054f76c7a5e1e29e6b3314dd7bd726d4569eeb8e1b1a9b3814dc448d16d32212ee268b1e0707bf0847f2b8f7bbe0b3a3b6e0a8ed0c7a94a74d1c026e9cbaf83e30ba91ce85c847fec2d106f493402f085d1b11b5a1c17615dac4bee386693ef967463730fa198e76c7a572d126348df8a7a33612a92d6de58eeb3b9bd867dca89dd0f4b24ff3c5efeb8e4b89b6a1f50a9bbe38d4a67672c7f5994dec2b6e9006f734ed99f7f7c8a1bc6945b411ed88fcde519b89d4b6063568c826f61137e600343dc20dfe654e6a0f6d653dbc69d47622b5b103dc717d6413fb861ba259604ddd7caf41cede4b13a1cd6818b12615b936a5b676843bae6f6c629f7023b49e7ed310cf17bb63521a176de8f9a14d55d4e64e74c7f4894dec0b6e80bef9dd875f53419fea8e496952b4a563f16fa3b655a7b6d7eb27019bd807045ebff9dd63ffffc523dd31294d8b3675f0a86dc5f6a636d8db770236b1eb08b8def6bb177eb7e2bfb963529a95dad6a88dc576a7b6d8cbde019bd865045afdfcaeab4f7f9df3c39fe68a36a619851a4c16db9fda64efc609d8c4ae22c01ae1e706f9e8f7d9c1ee9894da465b3b68d4e6623b54dbecd588419bd845045663fb9b46691deb8e49695e68735a1cd6bd80561bedcd80339bd8350454b3fa9a26f63cdf1d93d2bcd1f64e096db1a2b6da8b816736b16b0866d394de57b9fc292d0a6df02f439bac5ce1f2778d4dec1202a9c53c5c8035543317ec6c406cd6c176f843ec87c3713a5e86a7605fe4b6593322861a3178315c1bedfca22236b12b08a096f1727dfd9aacb19e3ba654c4430df1c1f89fd0b6daff8a1837e736bc13cf8376e2cd61d3132266da9de8dd88b155dbedf4f26236b10b089c16f0746ffcf5926523774c8988853ef88fc1a71163358d1fe1ed780eb4b67e3e658d8138dd199f448ca7da7067171ab5895d40d0dceabd1a70b1b3cb5f1ae2a00ffee3a06ffb18a736697f04dd8be3b1a52b4bba1df1d91e7aa28a317cabcbdf053671d90898d6ed8f4194235dfed21007fdb67f5f2d2e8ba2beefaba12eb04d5cd94a475c1e0b17bb4eee3b60139789406998afdbb4e37c97bf24c440dffada8ebc69dd8345d23b8637637fe4cf841ae2f15ac478a94d776eb8b04d5c1602a4c13e6ebb2eaddc7a27774c29a8bfbef5df3f8ac76ad4d8d417fd2778220e81be9976c3bda08954fa8dff7a28b64dd3a9c7a53dfa5f84ec550071d0b815b7c5bcda76a70609d9c46521386ea34eadddbe8bcb5f02eaae6ffd1330ceb7feb77012267a494afe2da06e42f520acb6cffe4a340dfb1d78248aee4da0fef781bb6757bafccb62139781c0688bee182c39cae52f0175d792d557d562d1e4ebd02698ebbbf34c8af3dc1d4fc0b9f812dc3557f3093cd09dbf14d45feb55b8d874666b729bb868046473b8fdf92f70f94b40ddb5a1e56adb5bebd15d4b9ecdb55b94f3ab3bf02ce851df95a3c9bfe31c14bb182b75d746b3312e6aeb9bbbfc8b6613178d609c570b4e45bbf614f9bb9f7aab3be90ba33834f922f671c7cf13d7dc135a2b6fa52db7a3efe289ee7c4347bdf514e736243dcfe55f349bb84804622fc49750faff2277e9a5de7a4977cb280e8e7e676bfcf952ff38727dbde8d2661ad7c195d3d14bc73bb8f30d1975d61a02ae8defe5f22f924d5c1402b02edcdbd222bbfca8f766d0e625311e152d3ad1b9454f2893f6d83b1b1a34e4ca5df71e6cecce3364d4d96d3fa6b6bfaecbbf28367151a8bcde58c7a0e8d1f2ae2eff9051e70df0c1510c1c3df2efe08eed0acab7315e0d3da5b83a54346cb9a82e43eaab773aee67d3492effa2d8c445a0e25be327b540549ee6f20f1df55e6917e38f620b775c1751564d2afaf8a8ec4df4a4d38917618b427dd55313e3a0cfc0d2fe18dac445a0d297d78250d15befe2469551e7a7d66210f56a85990a65d674e467c1cde6ace80f5b312f7aa9abc674b89e9dcb5dfe45b089f34685357c3406418f8df777f9878c3adf136e0289a87fbfd78fca945fcb69af3435f9b5eeb8a1a2beea52753f91f677f9e7cd26ce1315d58b3fd7c555e4ea3ed45b73f1632c44bf17073102927a3c0c1ad1e9ea298f72c70d15f5755b8ee933b1f0178236719ea8a4ba8e62e5bf83e266975167178bcaa1ee98bea23e5a53bfe949477fec8a7929485d3781da7c8cc3c267bbdac479a182fa0de4bab906b1d1e224a8b35691d1d8fd180bb9d41dd377d44b83889ade095ced8e192aeaeb8609ebb3b1d0776036715ea8dc61b5ca5634f9a4c4177f4df3c6356a6eb06fc7a9db0b6a758df674c70c11756dfa323ccce59f179b382f54eec650597992cb3b74d4fb43210e95c35dfea1a07eea1d681aefd0d99573e681faba9f8037babcf36213e7818a1d182a2a9a5c52e2d050f593c758885e040dfe69883a6e0bb7d1a6260f15b3e41b75d50bf12f8fea5e77a0cb3f0f36711ea8d4f5a192f2749777e8a8f745210e9567bafc43445d35d5d8c5e05c977fa8a8af1b1c74bdcb3b0f36b16d5448ebd2c74a6ac24b2f764f6993ea0cd725a637e4c5ac764c5d77469c2023df71f9878afaae876fd6ea5fd9cfe56f9b4d6c1b95b936544e3abf69c23c506ff589c758c8d92eff9051e7a63110bfebf20f15f57d66a8bf5cebf2b6cd26b6898aa8eb27564e0b226ce8f20f1df57e692d0e750f76f9878c3a6b3f03178b935dfea1a2be9a08f6bd5afd2b73ef15b1896da2126e92cb8b5cde1250f74b432c448b786ee0f20f1975deb21683ba6b5cfe21a3cea78618c8dcf717b4896da1029adffef35a85e4c7287989283719e44b2e6f09a8fb3f8658c8f75cde21a3ce1b21aea7a0cfce662e7f5b6c625b28bc7693a957485eedf29682fa6ba04f8cc9fb5dde125077ad1214e321c56dff469d5f116220c7bbbc6db1896da1f0eedbaed89562a9bbdef8ba37df17b9fc25a0eeda9f20c6437673f9878c3adf2fc4406e7079db6213db40c1770c15919b5cde52507f2d101963227feef29780ba3f3ec4a2f218977fe8a8f73f8438c88e2e6f1b6c621b28f499a112729acb5b0aeaaf1d64634ce4652e7f09a8fb3e211695e35cfea1a3deee89e84c97b70d3671561458131de21af21ae659f4d651d47fc35a3ceafec2e52f0175d70e3a2e2647bbfc4347bdb5298b3661adc7429fa5b90c11b789b3a2b0eeaf7a715d3b1131d0a299312e52dc20a00a7577bf7ba5c87d0484babf3bc442e6b207844d9c1585754b201737e73f22065a0822c6455ee3f29780ba6ba110179322df01087577ef45e6b254be4d9c0505d5a8a6b8f28b563e2d7a775f2106dafdb81e97caeb5dfe125077374b541ee9f29780baeb33a4f132f578e833d5fa60319b380b0aa95d66eb059762f7f8ab230e9a0b1f7fdfc9852e7f09a87b532fc0c35dfe52507fb7a760eb6b45d8c4595048f7f85fdc38f726c4e2db2136f2772e6f09a8fb1f8758541ee2f29782faef1be221adff0cb089b3a0907181030d6f2c6ec9af26c4e263b5d8546e76794b40dd4f09b1a83cc8e52f05f5574f5a1c1afc1597771636715a14709b5060b9cae52d15f1785b888ffcd4e52d0175ffef2116959d5cfe921083ab424c645b97775a36715a14eee8505839d1e52d15f1d07efe314652dc7e8842bddd6c512d17b68ecb5f126270622d2695635dde69d9c4695138b7d4d5ae2e6fa988c70b437c2a0f70f9878e7a6bf7a3188b4fbabca5210ebb86b8c8252eefb46ce2b428dc3742618b5ade691cc4e49810a3caa35dfe21a3ce770b31a814db2b12118bb881c82d2edfb46ce23428d8f6a1a032c80d2e66414cdcbe88f21c977fc8a8b3f60d74b1286a45a095100bb7804c6b5bc6d9c4695028b7bae9535dde921193fb8618555ee9f20f19757613c6e40097bf44c4c2ed1c7d82cb3b0d9b380d0ae5fe52dddbe52d1931392ec4a8b2b42da297853aff5d8841e51e2e7f8988c5bd436ce44a97771a36711a142afe56f99acb573262a20541dc4b2f39c71d3364d4f933210695fbbafca5221e5f0bf1d166aaad8cadb18993a2303bd40a57c9e1bf01313936c4a8a24541f772c70c1975bea41683ba97b8fca5221e1784f8482b7f246de2a4288c7b99f31497b764c4a46947a0935cfea1a3de3be197b538543ee5f2978a78b82f8e56664bdac44951989343e1646f97b764c4e413214695ed5cfe125077b72af0cf5cde52118fbd427ce4852eefa46ce2a4288c9b0034d82daea7454c7e1a62244a2b76ae0475bfbc168bbae2f64968422cb4bc7e8ccfc52eefa46ce2a4284cdceef9072e5fe9888bd645a8c7493ee2f29682faff658847652b97bf54c4e39f427c5a693736715214e6fba1701f76f94a475ce2484959d84eb05d44fddd84975f603d97bf54c4e3ba5a7ce456976f5236711214c43d9ebcd1e52d1d71f9548893dce6f29682fa7f3ec4438a9d1edd84989c1762245bbabc93b08993a0107b8742c9e92e6fe9884bd3c097df71f9878e7adf01fab68ff1788bcb5f3262f2bc10239979cd049b38090ae126b71ceaf2968eb89c11e25439d0e51f3aeabd4b8843e50c97bf64c4e48f428c64e6ae769b38090a71562894e4146083b83c3cc4a972aacb3f74d4fbd1210e95c7bafc2523266eb0ddccfb49d8c4495088b8c28d0676aceff2968eb86c0ab7376091b326a977d3da0839143820265a5036eeb4fd7697771236711214e273a150c56e753d0ee2e35e7a7d0fc58d05a0ceefacc5a0923d000d884bfcac7dcee59b844d9c048588abdc5ee7f2a5db119fa625c18ada0d97fa6aa3542dfd15e370a3cb9ffe3366d784587ddbe59b844d9c048588835bdee5f2a5db119f478578555ee5f20f15f53d2ad4bf52ec4ec9ab213671ccc44f5cbe49d8c47151002d5d1c7fd35ee6f2a6db111fed0ee426c068f3d43ddd3143433db501e60f46f58e720f8906c4e6e2102bb599997e3adac47171f18d6a85a99ce7f2a6df20466f0f31ab14f1f84b3d9ba601eb5d48fefe6f406cdccfc78d5cde71d9c47171f1ad4261e4af5ddef41bc4485b62bb013032e83101d46f5bb8272079b23b26dd8ef8bc3cc44b669a336113c7c5c5770e85911cc43106e27476885be5752eff50503fb7d6bd5c8fdc416a05c4e7c5b57855767679c76513c7c5c5770f8591e7b9bc694dc4497328dc5bf099bb76ba8cfab9c93fb2bbcb9f7e83189d14623673dc6ce2b8b8f8434261e4389737ad8d58bd3fc44ef452753397bfefa897dbef4ebeeaf2a7351127b742f04c9ba8dac47171f1434261e4092e6f5a1bb17a49885de52097bfefa8d76ea19e95735dfeb426e2f4b8103739c4e51d974d1c1717777db9836cbcf340acf60bb1abbcdce5ef3beae566b4492bebdb0d1d717213828e7279c76513c7c5c59f110a23fbbabc696dc46a036845e018c38fbafc7d47bde2ca51a21e8141fee4691b71dab716b7ca335cde71d9c471e9e2a130927f002640bcdc87425adbfea90ba8cfef86fa5506f9c76e1e8855e7fe00b89f0007bbbcc9235ecf0af1ab9cedf2f715f53937d4af52dc9e88d322560785d8c9527f02b897804f74799347bcee0af73340bbbfdcd11dd337d443c39fff6554af3a7583e6e3ff9888d5136ab1ab2cf525a0eb067cbacb9b9a11b3a6bef1235dfebea11eaeff5a2e72f99347bcdcbe924bed067403818a5cdd6616c4ec91218695de4fada60eebe28bb53ad51531f9a92dc4ebb9217eb2d481406e28f04b5dded48c9869714c4d8489b1945e7f4828ff09a13e95dcfe6b42c4cc8d1b59ea50603719a8a879ed6d216ecf0f71ac7c04bd1c234fb937871bf92747b863523362e6365159ea6420371d3877059e0271bb33e216eb955e7e5828f76b433d2ada233127fe4c8898b99e94a54e07760b825ce1f2a6d5113b37ae42be853bbb63ba8af2fe1e9aa6fdeee38e492b236e9786382e774110a1007149b06b5cbeb43a62b71ebe528b65dd9fba63ba88b2ea8be103b5b2d7bdd51d935647ecde1162b9dc25c18442c445416f70f9d27888df91219e959fe13eee98aea19c2fa895bb4e8ba0ece48e49ab23767f5f8ba5746251d0b854f1575cbe341ee2a76f4f374d5814eb4eff14a07c7f88a647ff5cf07306c4efe610cf4e2c0b1e3706d1ef92418c605b16e2a765b3dc56e2f237ee982ea06cdba069b14fbdf8cbf5fea644ec349e228e18edc4c6206e6bb0fbb9bc697cc4f06921a675c7bb63968932ad8f8fd5ca58f753e4a3ff0c889fd6918c71edc4d6606e73d0c35dde3419e27875886b455b447566092dcaa29f2d6f1c95cd39d61d97c6470cdd7e129dd81cd46d0ffe6297374d8638de13b7d6e25aa79183ffc51db74894417bd65d382a93935b7db78038ba81629dd81e5c8b5bc68215b9d9e53c10cbeb426cebf47b7b695b8a716d0d61be6c541647ef83eeee8e4d93218e17d5e25ad9d2e59d844d9c1405f97e2858eeefd602e2784088aba32784df77c7cf13d7d46ffef802d879a83b3e4d8638c6f72bb7ba7c93b28993a23071551bcdfdcea19e33207e1a47af1180f5b836f931fec09d671eb896d63078cfe8daabd1f0e6addd79d2f88861ec15fa88cb37299b38290a737e289c6ce3f2a6d511bb5df18fb5588e43836cf43b711d77ceb670fe83f15db83234f914b673e74bab23767a1714637ab1cb3b299b38290a7372289ceceff2a666c44c7dbd4f47d31800893fb7223d8db5fe61e39c9b60a537fdabf91172f5df2910370dae8af17ca1cb3b299b38290aa36f8558c067b9bcc9235e07e2a65afc9c2ba15983ab7d10f507e458ccfc338c73e82dbfbaa0be0177ad8ade45dc16d21c6d8c3ad31cf6d2102fb76e642b7f4c6de2a428cc0ea17072a1cb9bd6449c346beebdb5b835792bee503b4eabc3340db9ad68251e359e8debd71c07c76c81d3f055b873d76994dff6d05382e6acc719a2d1bf415385efe6ae9dd6449c5c37eb7d5dde49d9c46950a03897fd5b2e5fba1df1b9172e80bacaea7173f4adb9d6305ad21e0e3d5abb63eaf492f095d8137789e7199d4b5d7afa43aecd27fe061a6ce4ce15e9bceb8773a9f7a26985a33a3da968cbebff5a3f3ead89f8c497c15a30b69597ec36711a1428ce559641ad6ddf0662a28554b508e86adfde157d181bc7d0f36f1a22fa7f4679c7f54fd0bb828ba1d1865f82be955dde265ae9a771455afeedee18b7a740fe017aff914f0535c4c32dbb77a5cb3b0d9b380d0ae5c6aee77b0010870da1c61d674eae44eb028cb5e433f9b43293f68e77cb8bcfc3bbb16a2f0f79344458ef22c6791aa8e80fa3fe28695af486eebc2521066e3bf5135cde69d8c4695028fd068c057d87cb5b0aeaaf47eab331ce637a456be5ff093670e75c09c7e87a7f0b77de367c0813afe6c331fab97309567b3710693c899e52f670e72d01757783ad5a7bb2b689d3a260f14db17ee3fdfac55509a8af06f068fdf6ff8d491bbc7e1a6cebce3b09cea1dfe0ea7b77d798c6a7f147ee5a93e01c0fc0fb46e79cd4c7f1641433d59cbaaa5b387e79dce2f24ecb264e8bc2b9f1ca334f58e83aeaa847703db2be0b1a901363b01af502b43e6496736a3f3efd3458ad0bcff93cfe0cad0f33e69c0fc51598e6278bc641fc39eee5ce3d24d4718f519deb2e7179a76513a745e18e0e8595335cdebea35e77c4a3f166e8b13dd67b35ff8a3760ee6b27700dfd16df07fa69a19e077d0b7f192a837e9fdf887742abce6a50d742fae9b98eba1ad59df959b818ad44ef0ad435aaf11313ff5cea03eaf542c47ab73ab5da264e8bc269459858e0eb5ddebea23e9afd78069ad6bb5f8d86d1ea8338f34cae21211e1a0ff10a8c3bffa14edd6267625031a53efa1919eb3af34fc43a9b380b0aa86f967a81d5bdb489cbdb27d441dd5a7f819586e936d1b795bac4f433618d3ef3b426e2a3a795fdf0264cfa13414f62afc3bdddb9fb843adc09712c46ebeb6ddac4595048373168a61d4c9789b26f8a57639ac7fc8f4223f1b26f7b0ac44d7f745f8c499f0af4d3464f69bdfd6940d9dd54f0f35dde59d8c45950c8c343a1a5d517178b42b91f84afd7ea310e0dcad11e6e3bb873a6c9114b8d523c0cee9178251a4bf10877ceaea3dc7a3f14ebd3fa527b367116147203c44921faf6eccdcf00caaa0930fa9d3eee683d0d83567fff03ddf9527b88b1a64a6bf8b08637bb7b11a92bf639ee5c5d457935702cfed4d467aaf5271a9b382b0aea7e061ce7f2760de5d41fb06b6ae56ea286a59d5a345573ae73f0d3da88b976517a04ae85bb3f912629f562911acae97ad35a7ffc179b382b0aab2ea75881ceef184419b5cc55d34abc15bdd4fc5fc8a5cf3b827bb13b34ae60b589559aafd2f997b094d1ad033997fd146de2ac28acdee4ba69a49d9d074ed9f43b53b3ee6299eb3e8c5e6ccf5522ee8d063e696ab2bb77158d81b8933bbe0b289b8673c711a4fa2ccde5e9c526b68102ab5fb65e0939cbe5ed02caa62ebe58de8aba634e453eea771cf7487fc8358066a52ec457ba63bb80b2bd2c9455ce7479db6013db40a1770c95905bb0aecbbf4c9469273435184d48d9cf1d97ba8b7bb62f9ac66ce8675c2b0b6ab48932e9e5b3ebf2dcd1e56f834d6c0b05bf2154440e7479978932c56d972b6a40839fcb3054dcbbdf47d388cdf7b96396893269819758ceb9be3bb3896da1f0c787cac89b5dde65a13c4d6befeb85d2c296da4ef3c13ddc0b4db3320f73c72c0be5b93c944fe6ba0fa44d6c0b85d7b8f9389c51ffbf99cbbf6894432f2b9b26a2bcc11d93fa877be966a98a86ad77e2bd0ee558ca67c526b6890aa87ba65e2939c5e55d34caa19964b16ca247ff7bb86352ff702fb782762876f7ba134f0194e394502eb9c2e56d934d6c1395d04294b1625a936ee9cb3d5186a6c5299eeff2a7fee29ebaa9b5b2f4d9aa944123fff4998865dbd3e56f934d6c1b1571a3b54e75791785ebef16ca53f91a8a5975a614dc538df06c5a1865e17b2bd6717d7531c7325debf2b6cd26b68dca687a67aca0567659da5300d7d668be5826c9854c078a7beb3e687299cbbf085c5bdffe6eb7a785743ddbc479a042d7870acae92eefbc71ddbbc0f5fbabcfdfae9b9ffa8f7bab4d4de38b36515b58ca6435ae7b7aad1c9585fd2cb189f340a5dc0b37ed6fbf91cb3f4f5cf3885a19ea5eeff2a7e1e01e6b9f0577ef9fe8f2cf13d7d45a92fa0cc4b22c6cac8c4d9c172aa6b5e762655fe0f2ce13d7743d13727f973f0d07f778ef70cf2b6f71f9e7896bbe2094416e7479e7c526ce0b95d3a20eb1c25acf6de2bdeba6c5b5f432488ffab11c1f76f9d3f070afdd92e9ea265cd80a425c6b63a8edc7722cb45bd226ce0b95d3c09b9b6b95adb4b2d5f138b8d621e1da95135dfe343cdc6bf7cd2b07bbfcf3c0b55cb7a43e1b0b5db3c026ce1315d4c298b1e21aafbd90a700aee3765a955cc2ab10dceba62ee00b5cfeb6711d7dfbbb390a47bafcf36413e7894a6ab7932fd42a5d7985cbdf26aea16bbbc7ae2fbafc69b8b8e79a991adb815ec8cd7db62ad7d0f2e7f1dafa4c2c7ca6ac4d9c372aba7fade2154dd1dccde56f0be7d7cebcf1baf23f5cfe345cdc736d90e2dac2835dfeb6707e3d7db89d980f70f9e7cd262e021576339f3e89b9fd15e4dce7d4ae5537f3be77a95fb8e78f096da0f22a97bf0d9c5b4fa06ec5a285f740546ce22250e9ade1166c789ecb3f2bceab17906eb105ad21dfd925a2d27c70cf3781fb26fe86cbdf06cefd9c702d51efc33d5dfe45b0898b42c54faa05a2a22ebaed5cfe5970ce07d6ae51778dcb9f868f7bff81d0162aadff14e59cda22ddcd483cd9e55f149bb828545e8f44ae4ff66a977f169cf3d9e11a955ead199fdac3bd3f2db485ca092eff2c38a7768e8ed7d15a144bdd3edf262e1201685ab1e508977f5a9cef9270feca2e2e7f1a3eeefdfd425ba85ce8f24f8bf33d2e9c5fd4e697bee2944d5c3402715e2d3015cd90dadce59f06e7725d8f5f737953396803df0c6d426e7279a7c1b9b4b7a476848ed7b8c8e55f349bb868046373b84911adfc25e63cba09ee29e3752e7f2a076de0f5a14d88d6836c65921ae7715f6eb7a2135b99dbc4652020c7d4025437f3cc28cea1edbbdcb95bdf6c31f50b6de0f1a14d54661e0fc039d4eedc17cf5c17fa9c844d5c16027365089468c8e44cfbbd737cd37250735b6f3df5036d6097d0262a33ad5bc9f17aebef9e6ab5047d67f628b489cb4260b45087b6748e41fb34eeec8e1907c7bead76aecacf903bfd148e36a09e288d0589ed63eac1391cab19a76eeabb96246bedbd561b6ce23211206df4e856ebb9d4e51f07c7ba71df1f77795379680b1a811adbc7d42f8839f6e2702ef905f672f997c9262e1b816aadcf9e6334e2d09d2bd7fd4fff89b6f0c6d0362a13bfa8e39867857354963ae0a7894dec0202f6d61040d1d0cd895ece90ffd0daf17527b9fca93cb485e786b65199688e08f9b52dbe1b5efcb72e7f17d8c42e2068eabad312dd31985a3ffd77dc310e79ffac766cdd435dfe541edac2c342dba8bcc4e577c87b4f7caf766ce5ebe8c44e588e4dec0a02b707f4db2906f5e3186bed7ef2b99e05d9c2e54fe5a12d6c19da46e54d2e7f44be3be263b5e32a6abb73dfdc631636b14b0860d3e3d958bfe1c9e7e61a7cd7e54de5529b086d443ee6f246e43b3f1c5799cbccd636d9c4ae21904dabf89ee6f2d791c74d397eafcb9bca459bb826b411f9a1cb5b479ea6094573dfd7af0d36b16b08a61eb19aa66e36f60cf06f4d8f767fe5f2a772a94d843652d9d4e517fecdcdef17b5d55e6c2f6713bb88806a90d06746018eecf44dd235d3d0e53fdae54fe5a24d3c39b491caee0df94f08f92a6aa3bdd95dca26761581d536cfae6740e3ad8f33f9dd0ac4b2f46998a95b68130f0a6da4f20493f738b831fe6a9b5bc5fc5d6613bb8c00ef04b799a26ec83121ef4b6aff5e77af7abe946813db8436527951c8a7496beec3af36b9533d6f1fd8c4ae23d01a2eec9657d234ce5f2f24c27f5f54fbb7ca2fb1f0e59753b7a94dc00de2f9f59474fe5b7b4aaa8dc53c6a8bf6a742d7d9c43e20e007c08d11d007fcb1a33c1faaa557e6b6e863ea37b58dd056e483a37f7b2cd4b6e2bfab0d2e6549ef36d8c4be20f0fa8bec1ec7f497fcd1f84e2dadf22177ae94d436425b11b521b525f774a0b6d7ead2758b6613fb841b70e2e846c49be39e0e64ea598569d8d436425ba9b8b6a436d7fbfd246d62df7023f424d0f4818fce72e748496d23b495266a6bbdfee6afd8c43ee286e89d807b31183dc31d9f92da46682b8eda586f7ff34736b1afb831ea1d705d8475b90d58b2681b0785b612a96df5f26d7f139bd867dc208d137083852a390d3859b48dfd425ba9539bea5d3fff6a6c62df71a33462b069d8b02607ad35ba2b958d3671187e346a2391da52af46f88dcb260e01374c73079a261089d66bcf4d410b471bd044b3d78cda84a336d49bb1fd93b28943c18dd3cd6d9a4a2c9fc3aeeed8347cdcfbfb402b4ebbb6216a3bbd98d5372d9b3834dc442d2ad2d44da8dd88d7984390868f7bfe2434f51aa9ad3cd71d3734367188b8a15a5e6ca597835aca7943776c1a0edd63b8392215b5913ddcb1436413878a1bab8546dd6ac3952fe161eed8d47fbab7a37beceebda86d342e0032443671e8b8c9da77c06d3e52d156e27773c7a6fed1bd1cdd5377af456de1d9eed8a1b38925e0866bd090db86aca21d5c9f8eceece39626a37b37ba87ba97ee1e8bdac0a006f74cc22696821bafaec2a665c32b37e0f7dcf1a9bb74cf46f7ceddd38aeefd60bbf8c661134b4323d02a2f2b0d21d654d057205f12769ceed1e85eb9e9bb15edda9b3d3fb08925a2416c8673e1567ca9686eb8de1f6ce0ce919647f764746fdc1a10154de1d500b04eedd0bb4c36b164340e7517baad9debbe0dad4330e841227da07b30ba17ba27ee5e55b4414ce776e75d369b583a1a8ad6877b266e836b4c956fe278acefce93e647311fc55ef7c0dd9b8ae67e9c845c07d2b089e976349a7b60a5eea38a3680d452d1ebb9f3a4f628c6a3582be6ee5ed45d8eaddd79d2ed6c625a138de821b879d4a856a245255f847bb8f3a4e929a6a3d8ba853ba32f607f779eb4269b98d646835a078fc767e11a5d9dde40ab8b697fe43882292976a3182a962bbdd5afe88fb43683c9c7fd31d9c4d48cc6a546f9287c02ae11465f863690dcd29d2fad4db11ac54cb173318df4d256f3f9f38fed846c621a0f0deee1704b493b1a6e7a19b4ec547623068ac928368ad14ac3b4ebaec781ee7c693c36314d8646f8605c3b6a94e3d014e4ab7034eeeace5902d51dda9453b1504c5cac1cc57a3f77ce34199b98a643a3dc135a44e2e7700dd7d16e33d7e164ece8ce3b24d4717b687d06adb4e376da69a2982ab67bbaf3a6e9d8c4341b1aa94615aa8f7ab5b1e8cee7a111891a9ebc2b7afbbb5665c7ced0b7fc6b71135c9d57a2182a969bb96ba4d9d8c4d41e1aee8e38135f856be0abd160a4f7e2a5d06fe42ddc75ba80b26d8e037106de839566e1ad44b152cc06ff44b46c3631b58fc6ac6fc37d703e561b61b81a4d617d37b498a57e3a68efbaddb089bb769bb8c6c6b83f0e851ee5cfc1bbb0d2421be3504c141bc528dfe62f884d4cf34503d71befc3470d7edcaeae71fd10eaa27c0bf453e2afa06f5375ab9d00bd78d4b51f017dd844ffad34fd9bf228af8ed1b1afc39bf171fc33dc35a7a5ba2b06ba76f68c2c814d4c8b45e3df06faf069adba7146baf595eaa63aaaaedbb858a4c5b28969b9f870e84df9d3a0dd6a579adeda752abbeaa0ba6cefea9a96cb26a66ee1c3b3030e867eefeb91f983586d0fc445525934204a653b052aeb0eae2ea95b6c62ea073e64ea6edc1bea32d4d6d66f83363bd1dc784d83d50218ee033b099d43e7ba05eac67b3b5e8e63a16be7e21a3d6613d330f0e154cfc346d05e89ea8fd742a89ad978088e82b6c316fdb7d2f46fcaa3bc5b43c7e61bf901b38929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b08929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a6944af0abdffa0f50331f92e214a57e0000000049454e44ae426082),
(17, '12', 0x89504e470d0a1a0a0000000d49484452000001000000010008060000005c72a8660000000467414d410000b18f0bfc61050000290049444154785eeddd79dc345579e6f10404511601410583208b806322a384650c881a500222226e80022a11414565738b01c7046312d4c1510411c880a0801a9720a21351c495b88119f715351a11354e1c63c6fcaed0a5f5deef55cfd34b7577559dfb8fefe703e73d5575ce5da79faeaeb3fdd6af7ef5ab9452a16c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b08929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b089691876d876bbdfc646d80a3b63773c0487e0283c6344ffad34fd9bf228af8ed1b1bfedce9d86c126a67ee0c3b919f6c631380b6fc3e7f06dfc04ff1fbf9a91cea173e99c3ab7aea16be99abaf666ae6ca91f6c62ea163e643be0609c8cf3f1417c1fee03bb0c2a8bcaa4b2a98c2aeb0eae2ea95b6c625a2e3e3cdbe369b814df81fbd0f581caae3aa82edbbbbaa6e5b28969b1f8706c83a37111be01f7611a02d54d75545db771b1488b6513d37cd1f837c0e1d023f397e13e2cd3f825be84ebf02e5c86f3f0d73803cfc37178020ec2be23fa6fa5e9df94e74fa16374accea173e99c3ab7aee1ae3d0dd55d31502c3670b14af3651353fb68e07a23bfcfa8c1df06f78118d70ff061bc11a7e350ec8af5ddb5dba46b8caea56beada2a83caa232b9b28e4b31516c14a3ec7958109b98da4363de1167e2ab700d7f355fc305780af4d67d73779d2e50d946655459556695ddd569358a9562b6a3bb4e6a8f4d4cb3a1e1aa7bee78dc00d7c05752bd387b2aeeedcedf27d4613be80fc225b805aece2b510c15cbec6e9c039b98a64323dd1357e0e7708dd9f921aec289d8d59d7748a8a3061969f091e234c9cf06c554c7ece9ce9ba66313d3646894fbe15ab886eb68608d1e911f8c627fefaaeef8034cfa5e44b1decf9d334dc626a6f1d0080fc4f5a346b99a7fc73538027772e72b996202f5445c8d717b1a14fb03ddf9d2786c626a4683d3b7d661b811ae514637e1346cedce97d646ac340fe15468e8b18b69a47ba17b92bd0713b289696d34ae7571246e866b84753fc6abf14077ae343e62f880512c155317eb3add1bdda375ddb9d2da6c625a130d6a7f7c01aed1d5fd335e8c4ddd79d2f488e95df0228cf3e250f76a7f779eb4269b986e4723da1a978f1ad54ad475a749301bbaf3a4f628c6782ec6e952d4bdcb9f5e2bb089a5a3d1e871ff24e86dbd6b5895af435d5a7774e749f3a398e3e9586d8095eea1ee65fe2c306c62c968287be153708da9a2474ccd87bf833b475a1cdd033c099f87bb5715ddd3bddc394a66134b44e3d030564d7e5969118defe1c958c79d232d0ff744bd33ea625d69fab4eeadee716787532f9a4d2c0d0d42dfe62bbd5c521ffe39b88b3b3e7507f76813bc0a2b8d25d0bd3ec61d5f1a9b580a1a81de2c5f396a144d3e8a07b8e3537771cfee8fd5e662e8de17fd47dd2696801bafc52fbf326a088ec6e8ff317270494fe9de41ab11a97bd6dd63511bd8dd1d5f029b3874dcf067e3ff8d1a40a4df896fc016eed8d43fdccbbb42f30d9adeefa82d3cdb1d3b743671a8b8c99be2ada39bee68d8eedeeed8d47fbab7a37beceebda86d143588cb260e1137760facb4408556b6b9b33b360d07f758938e3413d3b501511bd9c31d3b44367168b8a11a39f68bd10d8efe054f76c7a5e1e29e6b3314dd7bd726d4569eeb8e1b1a9b3814dc448d16d32212ee268b1e0707bf0847f2b8f7bbe0b3a3b6e0a8ed0c7a94a74d1c026e9cbaf83e30ba91ce85c847fec2d106f493402f085d1b11b5a1c17615dac4bee386693ef967463730fa198e76c7a572d126348df8a7a33612a92d6de58eeb3b9bd867dca89dd0f4b24ff3c5efeb8e4b89b6a1f50a9bbe38d4a67672c7f5994dec2b6e9006f734ed99f7f7c8a1bc6945b411ed88fcde519b89d4b6063568c826f61137e600343dc20dfe654e6a0f6d653dbc69d47622b5b103dc717d6413fb861ba259604ddd7caf41cede4b13a1cd6818b12615b936a5b676843bae6f6c629f7023b49e7ed310cf17bb63521a176de8f9a14d55d4e64e74c7f4894dec0b6e80bef9dd875f53419fea8e496952b4a563f16fa3b655a7b6d7eb27019bd807045ebff9dd63ffffc523dd31294d8b3675f0a86dc5f6a636d8db770236b1eb08b8def6bb177eb7e2bfb963529a95dad6a88dc576a7b6d8cbde019bd865045afdfcaeab4f7f9df3c39fe68a36a619851a4c16db9fda64efc609d8c4ae22c01ae1e706f9e8f7d9c1ee9894da465b3b68d4e6623b54dbecd588419bd845045663fb9b46691deb8e49695e68735a1cd6bd80561bedcd80339bd8350454b3fa9a26f63cdf1d93d2bcd1f64e096db1a2b6da8b816736b16b0866d394de57b9fc292d0a6df02f439bac5ce1f2778d4dec1202a9c53c5c8035543317ec6c406cd6c176f843ec87c3713a5e86a7605fe4b6593322861a3178315c1bedfca22236b12b08a096f1727dfd9aacb19e3ba654c4430df1c1f89fd0b6daff8a1837e736bc13cf8376e2cd61d3132266da9de8dd88b155dbedf4f26236b10b089c16f0746ffcf5926523774c8988853ef88fc1a71163358d1fe1ed780eb4b67e3e658d8138dd199f448ca7da7067171ab5895d40d0dceabd1a70b1b3cb5f1ae2a00ffee3a06ffb18a736697f04dd8be3b1a52b4bba1df1d91e7aa28a317cabcbdf053671d90898d6ed8f4194235dfed21007fdb67f5f2d2e8ba2beefaba12eb04d5cd94a475c1e0b17bb4eee3b60139789406998afdbb4e37c97bf24c440dffada8ebc69dd8345d23b8637637fe4cf841ae2f15ac478a94d776eb8b04d5c1602a4c13e6ebb2eaddc7a27774c29a8bfbef5df3f8ac76ad4d8d417fd2778220e81be9976c3bda08954fa8dff7a28b64dd3a9c7a53dfa5f84ec550071d0b815b7c5bcda76a70609d9c46521386ea34eadddbe8bcb5f02eaae6ffd1330ceb7feb77012267a494afe2da06e42f520acb6cffe4a340dfb1d78248aee4da0fef781bb6757bafccb62139781c0688bee182c39cae52f0175d792d557d562d1e4ebd02698ebbbf34c8af3dc1d4fc0b9f812dc3557f3093cd09dbf14d45feb55b8d874666b729bb868046473b8fdf92f70f94b40ddb5a1e56adb5bebd15d4b9ecdb55b94f3ab3bf02ce851df95a3c9bfe31c14bb182b75d746b3312e6aeb9bbbfc8b6613178d609c570b4e45bbf614f9bb9f7aab3be90ba33834f922f671c7cf13d7dc135a2b6fa52db7a3efe289ee7c4347bdf514e736243dcfe55f349bb84804622fc49750faff2277e9a5de7a4977cb280e8e7e676bfcf952ff38727dbde8d2661ad7c195d3d14bc73bb8f30d1975d61a02ae8defe5f22f924d5c1402b02edcdbd222bbfca8f766d0e625311e152d3ad1b9454f2893f6d83b1b1a34e4ca5df71e6cecce3364d4d96d3fa6b6bfaecbbf28367151a8bcde58c7a0e8d1f2ae2eff9051e70df0c1510c1c3df2efe08eed0acab7315e0d3da5b83a54346cb9a82e43eaab773aee67d3492effa2d8c445a0e25be327b540549ee6f20f1df55e6917e38f620b775c1751564d2afaf8a8ec4df4a4d38917618b427dd55313e3a0cfc0d2fe18dac445a0d297d78250d15befe2469551e7a7d66210f56a85990a65d674e467c1cde6ace80f5b312f7aa9abc674b89e9dcb5dfe45b089f34685357c3406418f8df777f9878c3adf136e0289a87fbfd78fca945fcb69af3435f9b5eeb8a1a2beea52753f91f677f9e7cd26ce1315d58b3fd7c555e4ea3ed45b73f1632c44bf17073102927a3c0c1ad1e9ea298f72c70d15f5755b8ee933b1f0178236719ea8a4ba8e62e5bf83e266975167178bcaa1ee98bea23e5a53bfe949477fec8a7929485d3781da7c8cc3c267bbdac479a182fa0de4bab906b1d1e224a8b35691d1d8fd180bb9d41dd377d44b83889ade095ced8e192aeaeb8609ebb3b1d0776036715ea8dc61b5ca5634f9a4c4177f4df3c6356a6eb06fc7a9db0b6a758df674c70c11756dfa323ccce59f179b382f54eec650597992cb3b74d4fb43210e95c35dfea1a07eea1d681aefd0d99573e681faba9f8037babcf36213e7818a1d182a2a9a5c52e2d050f593c758885e040dfe69883a6e0bb7d1a6260f15b3e41b75d50bf12f8fea5e77a0cb3f0f36711ea8d4f5a192f2749777e8a8f745210e9567bafc43445d35d5d8c5e05c977fa8a8af1b1c74bdcb3b0f36b16d5448ebd2c74a6ac24b2f764f6993ea0cd725a637e4c5ac764c5d77469c2023df71f9878afaae876fd6ea5fd9cfe56f9b4d6c1b95b936544e3abf69c23c506ff589c758c8d92eff9051e7a63110bfebf20f15f57d66a8bf5cebf2b6cd26b6898aa8eb27564e0b226ce8f20f1df57e692d0e750f76f9878c3a6b3f03178b935dfea1a2be9a08f6bd5afd2b73ef15b1896da2126e92cb8b5cde1250f74b432c448b786ee0f20f1975deb21683ba6b5cfe21a3cea78618c8dcf717b4896da1029adffef35a85e4c7287989283719e44b2e6f09a8fb3f8658c8f75cde21a3ce1b21aea7a0cfce662e7f5b6c625b28bc7693a957485eedf29682fa6ba04f8cc9fb5dde125077ad1214e321c56dff469d5f116220c7bbbc6db1896da1f0eedbaed89562a9bbdef8ba37df17b9fc25a0eeda9f20c6437673f9878c3adf2fc4406e7079db6213db40c1770c15919b5cde52507f2d101963227feef29780ba3f3ec4a2f218977fe8a8f73f8438c88e2e6f1b6c621b28f499a112729acb5b0aeaaf1d64634ce4652e7f09a8fb3e211695e35cfea1a3deee89e84c97b70d3671561458131de21af21ae659f4d651d47fc35a3ceafec2e52f0175d70e3a2e2647bbfc4347bdb5298b3661adc7429fa5b90c11b789b3a2b0eeaf7a715d3b1131d0a299312e52dc20a00a7577bf7ba5c87d0484babf3bc442e6b207844d9c1585754b201737e73f22065a0822c6455ee3f29780ba6ba110179322df01087577ef45e6b254be4d9c0505d5a8a6b8f28b563e2d7a775f2106dafdb81e97caeb5dfe125077374b541ee9f29780baeb33a4f132f578e833d5fa60319b380b0aa95d66eb059762f7f8ab230e9a0b1f7fdfc9852e7f09a87b532fc0c35dfe52507fb7a760eb6b45d8c4595048f7f85fdc38f726c4e2db2136f2772e6f09a8fb1f8758541ee2f29782faef1be221adff0cb089b3a0907181030d6f2c6ec9af26c4e263b5d8546e76794b40dd4f09b1a83cc8e52f05f5574f5a1c1afc1597771636715a14709b5060b9cae52d15f1785b888ffcd4e52d0175ffef2116959d5cfe921083ab424c645b97775a36715a14eee8505839d1e52d15f1d07efe314652dc7e8842bddd6c512d17b68ecb5f126270622d2695635dde69d9c4695138b7d4d5ae2e6fa988c70b437c2a0f70f9878e7a6bf7a3188b4fbabca5210ebb86b8c8252eefb46ce2b428dc3742618b5ade691cc4e49810a3caa35dfe21a3ce770b31a814db2b12118bb881c82d2edfb46ce23428d8f6a1a032c80d2e66414cdcbe88f21c977fc8a8b3f60d74b1286a45a095100bb7804c6b5bc6d9c4695028b7bae9535dde921193fb8618555ee9f20f19757613c6e40097bf44c4c2ed1c7d82cb3b0d9b380d0ae5fe52dddbe52d1931392ec4a8b2b42da297853aff5d8841e51e2e7f8988c5bd436ce44a97771a36711a142afe56f99acb573262a20541dc4b2f39c71d3364d4f933210695fbbafca5221e5f0bf1d166aaad8cadb18993a2303bd40a57c9e1bf01313936c4a8a24541f772c70c1975bea41683ba97b8fca5221e1784f8482b7f246de2a4288c7b99f31497b764c4a46947a0935cfea1a3de3be197b538543ee5f2978a78b82f8e56664bdac44951989343e1646f97b764c4e413214695ed5cfe125077b72af0cf5cde52118fbd427ce4852eefa46ce2a4288c9b0034d82daea7454c7e1a62244a2b76ae0475bfbc168bbae2f64968422cb4bc7e8ccfc52eefa46ce2a4284cdceef9072e5fe9888bd645a8c7493ee2f29682faff658847652b97bf54c4e39f427c5a693736715214e6fba1701f76f94a475ce2484959d84eb05d44fddd84975f603d97bf54c4e3ba5a7ce456976f5236711214c43d9ebcd1e52d1d71f9548893dce6f29682fa7f3ec4438a9d1edd84989c1762245bbabc93b08993a0107b8742c9e92e6fe9884bd3c097df71f9878e7adf01fab68ff1788bcb5f3262f2bc10239979cd049b38090ae126b71ceaf2968eb89c11e25439d0e51f3aeabd4b8843e50c97bf64c4e48f428c64e6ae769b38090a71562894e4146083b83c3cc4a972aacb3f74d4fbd1210e95c7bafc2523266eb0ddccfb49d8c4495088b8c28d0676aceff2968eb86c0ab7376091b326a977d3da0839143820265a5036eeb4fd7697771236711214e273a150c56e753d0ee2e35e7a7d0fc58d05a0ceefacc5a0923d000d884bfcac7dcee59b844d9c048588abdc5ee7f2a5db119fa625c18ada0d97fa6aa3542dfd15e370a3cb9ffe3366d784587ddbe59b844d9c048588835bdee5f2a5db119f478578555ee5f20f15f53d2ad4bf52ec4ec9ab213671ccc44f5cbe49d8c47151002d5d1c7fd35ee6f2a6db111fed0ee426c068f3d43ddd3143433db501e60f46f58e720f8906c4e6e2102bb599997e3adac47171f18d6a85a99ce7f2a6df20466f0f31ab14f1f84b3d9ba601eb5d48fefe6f406cdccfc78d5cde71d9c47171f1ad4261e4af5ddef41bc4485b62bb013032e83101d46f5bb8272079b23b26dd8ef8bc3cc44b669a336113c7c5c5770e85911cc43106e27476885be5752eff50503fb7d6bd5c8fdc416a05c4e7c5b57855767679c76513c7c5c5770f8591e7b9bc694dc4497328dc5bf099bb76ba8cfab9c93fb2bbcb9f7e83189d14623673dc6ce2b8b8f8434261e4389737ad8d58bd3fc44ef452753397bfefa897dbef4ebeeaf2a7351127b742f04c9ba8dac47171f1434261e4092e6f5a1bb17a49885de52097bfefa8d76ea19e95735dfeb426e2f4b8103739c4e51d974d1c1717777db9836cbcf340acf60bb1abbcdce5ef3beae566b4492bebdb0d1d717213828e7279c76513c7c5c59f110a23fbbabc696dc46a036845e018c38fbafc7d47bde2ca51a21e8141fee4691b71dab716b7ca335cde71d9c471e9e2a130927f002640bcdc87425adbfea90ba8cfef86fa5506f9c76e1e8855e7fe00b89f0007bbbcc9235ecf0af1ab9cedf2f715f53937d4af52dc9e88d322560785d8c9527f02b897804f74799347bcee0af73340bbbfdcd11dd337d443c39fff6554af3a7583e6e3ff9888d5136ab1ab2cf525a0eb067cbacb9b9a11b3a6bef1235dfebea11eaeff5a2e72f99347bcdcbe924bed067403818a5cdd6616c4ec91218695de4fada60eebe28bb53ad51531f9a92dc4ebb9217eb2d481406e28f04b5dded48c9869714c4d8489b1945e7f4828ff09a13e95dcfe6b42c4cc8d1b59ea50603719a8a879ed6d216ecf0f71ac7c04bd1c234fb937871bf92747b863523362e6365159ea6420371d3877059e0271bb33e216eb955e7e5828f76b433d2ada233127fe4c8898b99e94a54e07760b825ce1f2a6d5113b37ae42be853bbb63ba8af2fe1e9aa6fdeee38e492b236e9786382e774110a1007149b06b5cbeb43a62b71ebe528b65dd9fba63ba88b2ea8be103b5b2d7bdd51d935647ecde1162b9dc25c18442c445416f70f9d27888df91219e959fe13eee98aea19c2fa895bb4e8ba0ece48e49ab23767f5f8ba5746251d0b854f1575cbe341ee2a76f4f374d5814eb4eff14a07c7f88a647ff5cf07306c4efe610cf4e2c0b1e3706d1ef92418c605b16e2a765b3dc56e2f237ee982ea06cdba069b14fbdf8cbf5fea644ec349e228e18edc4c6206e6bb0fbb9bc697cc4f06921a675c7bb63968932ad8f8fd5ca58f753e4a3ff0c889fd6918c71edc4d6606e73d0c35dde3419e27875886b455b447566092dcaa29f2d6f1c95cd39d61d97c6470cdd7e129dd81cd46d0ffe6297374d8638de13b7d6e25aa79183ffc51db74894417bd65d382a93935b7db78038ba81629dd81e5c8b5bc68215b9d9e53c10cbeb426cebf47b7b695b8a716d0d61be6c541647ef83eeee8e4d93218e17d5e25ad9d2e59d844d9c1405f97e2858eeefd602e2784088aba32784df77c7cf13d7d46ffef802d879a83b3e4d8638c6f72bb7ba7c93b28993a23071551bcdfdcea19e33207e1a47af1180f5b836f931fec09d671eb896d63078cfe8daabd1f0e6addd79d2f88861ec15fa88cb37299b38290a737e289c6ce3f2a6d511bb5df18fb5588e43836cf43b711d77ceb670fe83f15db83234f914b673e74bab23767a1714637ab1cb3b299b38290a7372289ceceff2a666c44c7dbd4f47d31800893fb7223d8db5fe61e39c9b60a537fdabf91172f5df2910370dae8af17ca1cb3b299b38290aa36f8558c067b9bcc9235e07e2a65afc9c2ba15983ab7d10f507e458ccfc338c73e82dbfbaa0be0177ad8ade45dc16d21c6d8c3ad31cf6d2102fb76e642b7f4c6de2a428cc0ea17072a1cb9bd6449c346beebdb5b835792bee503b4eabc3340db9ad68251e359e8debd71c07c76c81d3f055b873d76994dff6d05382e6acc719a2d1bf415385efe6ae9dd6449c5c37eb7d5dde49d9c46950a03897fd5b2e5fba1df1b9172e80bacaea7173f4adb9d6305ad21e0e3d5abb63eaf492f095d8137789e7199d4b5d7afa43aecd27fe061a6ce4ce15e9bceb8773a9f7a26985a33a3da968cbebff5a3f3ead89f8c497c15a30b69597ec36711a1428ce559641ad6ddf0662a28554b508e86adfde157d181bc7d0f36f1a22fa7f4679c7f54fd0bb828ba1d1865f82be955dde265ae9a771455afeedee18b7a740fe017aff914f0535c4c32dbb77a5cb3b0d9b380d0ae5c6aee77b0010870da1c61d674eae44eb028cb5e433f9b43293f68e77cb8bcfc3bbb16a2f0f79344458ef22c6791aa8e80fa3fe28695af486eebc2521066e3bf5135cde69d8c4695028fd068c057d87cb5b0aeaaf47eab331ce637a456be5ff093670e75c09c7e87a7f0b77de367c0813afe6c331fab97309567b3710693c899e52f670e72d01757783ad5a7bb2b689d3a260f14db17ee3fdfac55509a8af06f068fdf6ff8d491bbc7e1a6cebce3b09cea1dfe0ea7b77d798c6a7f147ee5a93e01c0fc0fb46e79cd4c7f1641433d59cbaaa5b387e79dce2f24ecb264e8bc2b9f1ca334f58e83aeaa847703db2be0b1a901363b01af502b43e6496736a3f3efd3458ad0bcff93cfe0cad0f33e69c0fc51598e6278bc641fc39eee5ce3d24d4718f519deb2e7179a76513a745e18e0e8595335cdebea35e77c4a3f166e8b13dd67b35ff8a3760ee6b27700dfd16df07fa69a19e077d0b7f192a837e9fdf887742abce6a50d742fae9b98eba1ad59df959b818ad44ef0ad435aaf11313ff5cea03eaf542c47ab73ab5da264e8bc269459858e0eb5ddebea23e9afd78069ad6bb5f8d86d1ea8338f34cae21211e1a0ff10a8c3bffa14edd6267625031a53efa1919eb3af34fc43a9b380b0aa86f967a81d5bdb489cbdb27d441dd5a7f819586e936d1b795bac4f433618d3ef3b426e2a3a795fdf0264cfa13414f62afc3bdddb9fb843adc09712c46ebeb6ddac4595048373168a61d4c9789b26f8a57639ac7fc8f4223f1b26f7b0ac44d7f745f8c499f0af4d3464f69bdfd6940d9dd54f0f35dde59d8c45950c8c343a1a5d517178b42b91f84afd7ea310e0dcad11e6e3bb873a6c9114b8d523c0cee9178251a4bf10877ceaea3dc7a3f14ebd3fa527b367116147203c44921faf6eccdcf00caaa0930fa9d3eee683d0d83567fff03ddf9527b88b1a64a6bf8b08637bb7b11a92bf639ee5c5d457935702cfed4d467aaf5271a9b382b0aea7e061ce7f2760de5d41fb06b6ae56ea286a59d5a345573ae73f0d3da88b976517a04ae85bb3f912629f562911acae97ad35a7ffc179b382b0aab2ea75881ceef184419b5cc55d34abc15bdd4fc5fc8a5cf3b827bb13b34ae60b589559aafd2f997b094d1ad033997fd146de2ac28acdee4ba69a49d9d074ed9f43b53b3ee6299eb3e8c5e6ccf5522ee8d063e696ab2bb77158d81b8933bbe0b289b8673c711a4fa2ccde5e9c526b68102ab5fb65e0939cbe5ed02caa62ebe58de8aba634e453eea771cf7487fc8358066a52ec457ba63bb80b2bd2c9455ce7479db6013db40a1770c95905bb0aecbbf4c9469273435184d48d9cf1d97ba8b7bb62f9ac66ce8675c2b0b6ab48932e9e5b3ebf2dcd1e56f834d6c0b05bf2154440e7479978932c56d972b6a40839fcb3054dcbbdf47d388cdf7b96396893269819758ceb9be3bb3896da1f0c787cac89b5dde65a13c4d6befeb85d2c296da4ef3c13ddc0b4db3320f73c72c0be5b93c944fe6ba0fa44d6c0b85d7b8f9389c51ffbf99cbbf6894432f2b9b26a2bcc11d93fa877be966a98a86ad77e2bd0ee558ca67c526b6890aa87ba65e2939c5e55d34caa19964b16ca247ff7bb86352ff702fb782762876f7ba134f0194e394502eb9c2e56d934d6c1395d04294b1625a936ee9cb3d5186a6c5299eeff2a7fee29ebaa9b5b2f4d9aa944123fff4998865dbd3e56f934d6c1b1571a3b54e75791785ebef16ca53f91a8a5975a614dc538df06c5a1865e17b2bd6717d7531c7325debf2b6cd26b68dca687a67aca0567659da5300d7d668be5826c9854c078a7beb3e687299cbbf085c5bdffe6eb7a785743ddbc479a042d7870acae92eefbc71ddbbc0f5fbabcfdfae9b9ffa8f7bab4d4de38b36515b58ca6435ae7b7aad1c9585fd2cb189f340a5dc0b37ed6fbf91cb3f4f5cf3885a19ea5eeff2a7e1e01e6b9f0577ef9fe8f2cf13d7d45a92fa0cc4b22c6cac8c4d9c172aa6b5e762655fe0f2ce13d7743d13727f973f0d07f778ef70cf2b6f71f9e7896bbe2094416e7479e7c526ce0b95d3a20eb1c25acf6de2bdeba6c5b5f432488ffab11c1f76f9d3f070afdd92e9ea265cd80a425c6b63a8edc7722cb45bd226ce0b95d3c09b9b6b95adb4b2d5f138b8d621e1da95135dfe343cdc6bf7cd2b07bbfcf3c0b55cb7a43e1b0b5db3c026ce1315d4c298b1e21aafbd90a700aee3765a955cc2ab10dceba62ee00b5cfeb6711d7dfbbb390a47bafcf36413e7894a6ab7932fd42a5d7985cbdf26aea16bbbc7ae2fbafc69b8b8e79a991adb815ec8cd7db62ad7d0f2e7f1dafa4c2c7ca6ac4d9c372aba7fade2154dd1dccde56f0be7d7cebcf1baf23f5cfe345cdc736d90e2dac2835dfeb6707e3d7db89d980f70f9e7cd262e021576339f3e89b9fd15e4dce7d4ae5537f3be77a95fb8e78f096da0f22a97bf0d9c5b4fa06ec5a285f740546ce22250e9ade1166c789ecb3f2bceab17906eb105ad21dfd925a2d27c70cf3781fb26fe86cbdf06cefd9c702d51efc33d5dfe45b0898b42c54faa05a2a22ebaed5cfe5970ce07d6ae51778dcb9f868f7bff81d0162aadff14e59cda22ddcd483cd9e55f149bb828545e8f44ae4ff66a977f169cf3d9e11a955ead199fdac3bd3f2db485ca092eff2c38a7768e8ed7d15a144bdd3edf262e1201685ab1e508977f5a9cef9270feca2e2e7f1a3eeefdfd425ba85ce8f24f8bf33d2e9c5fd4e697bee2944d5c3402715e2d3015cd90dadce59f06e7725d8f5f737953396803df0c6d426e7279a7c1b9b4b7a476848ed7b8c8e55f349bb868046373b84911adfc25e63cba09ee29e3752e7f2a076de0f5a14d88d6836c65921ae7715f6eb7a2135b99dbc4652020c7d4025437f3cc28cea1edbbdcb95bdf6c31f50b6de0f1a14d54661e0fc039d4eedc17cf5c17fa9c844d5c16027365089468c8e44cfbbd737cd37250735b6f3df5036d6097d0262a33ad5bc9f17aebef9e6ab5047d67f628b489cb4260b45087b6748e41fb34eeec8e1907c7bead76aecacf903bfd148e36a09e288d0589ed63eac1391cab19a76eeabb96246bedbd561b6ce23211206df4e856ebb9d4e51f07c7ba71df1f77795379680b1a811adbc7d42f8839f6e2702ef905f672f997c9262e1b816aadcf9e6334e2d09d2bd7fd4fff89b6f0c6d0362a13bfa8e39867857354963ae0a7894dec0202f6d61040d1d0cd895ece90ffd0daf17527b9fca93cb485e786b65199688e08f9b52dbe1b5efcb72e7f17d8c42e2068eabad312dd31985a3ffd77dc310e79ffac766cdd435dfe541edac2c342dba8bcc4e577c87b4f7caf766ce5ebe8c44e588e4dec0a02b707f4db2906f5e3186bed7ef2b99e05d9c2e54fe5a12d6c19da46e54d2e7f44be3be263b5e32a6abb73dfdc631636b14b0860d3e3d958bfe1c9e7e61a7cd7e54de5529b086d443ee6f246e43b3f1c5799cbccd636d9c4ae21904dabf89ee6f2d791c74d397eafcb9bca459bb826b411f9a1cb5b479ea6094573dfd7af0d36b16b08a61eb19aa66e36f60cf06f4d8f767fe5f2a772a94d843652d9d4e517fecdcdef17b5d55e6c2f6713bb88806a90d06746018eecf44dd235d3d0e53fdae54fe5a24d3c39b491caee0df94f08f92a6aa3bdd95dca26761581d536cfae6740e3ad8f33f9dd0ac4b2f46998a95b68130f0a6da4f20493f738b831fe6a9b5bc5fc5d6613bb8c00ef04b799a26ec83121ef4b6aff5e77af7abe946813db8436527951c8a7496beec3af36b9533d6f1fd8c4ae23d01a2eec9657d234ce5f2f24c27f5f54fbb7ca2fb1f0e59753b7a94dc00de2f9f59474fe5b7b4aaa8dc53c6a8bf6a742d7d9c43e20e007c08d11d007fcb1a33c1faaa557e6b6e863ea37b58dd056e483a37f7b2cd4b6e2bfab0d2e6549ef36d8c4be20f0fa8bec1ec7f497fcd1f84e2dadf22177ae94d436425b11b521b525f774a0b6d7ead2758b6613fb841b70e2e846c49be39e0e64ea598569d8d436425ba9b8b6a436d7fbfd246d62df7023f424d0f4818fce72e748496d23b495266a6bbdfee6afd8c43ee286e89d807b31183dc31d9f92da46682b8eda586f7ff34736b1afb831ea1d705d8475b90d58b2681b0785b612a96df5f26d7f139bd867dc208d137083852a390d3859b48dfd425ba9539bea5d3fff6a6c62df71a33462b069d8b02607ad35ba2b958d3671187e346a2391da52af46f88dcb260e01374c73079a261089d66bcf4d410b471bd044b3d78cda84a336d49bb1fd93b28943c18dd3cd6d9a4a2c9fc3aeeed8347cdcfbfb402b4ebbb6216a3bbd98d5372d9b3834dc442d2ad2d44da8dd88d7984390868f7bfe2434f51aa9ad3cd71d3734367188b8a15a5e6ca597835aca7943776c1a0edd63b8392215b5913ddcb1436413878a1bab8546dd6ac3952fe161eed8d47fbab7a37beceebda86d342e0032443671e8b8c9da77c06d3e52d156e27773c7a6fed1bd1cdd5377af456de1d9eed8a1b38925e0866bd090db86aca21d5c9f8eceece39626a37b37ba87ba97ee1e8bdac0a006f74cc22696821bafaec2a665c32b37e0f7dcf1a9bb74cf46f7ceddd38aeefd60bbf8c661134b4323d02a2f2b0d21d654d057205f12769ceed1e85eb9e9bb15edda9b3d3fb08925a2416c8673e1567ca9686eb8de1f6ce0ce919647f764746fdc1a10154de1d500b04eedd0bb4c36b164340e7517baad9debbe0dad4330e841227da07b30ba17ba27ee5e55b4414ce776e75d369b583a1a8ad6877b266e836b4c956fe278acefce93e647311fc55ef7c0dd9b8ae67e9c845c07d2b089e976349a7b60a5eea38a3680d452d1ebb9f3a4f628c6a3582be6ee5ed45d8eaddd79d2ed6c625a138de821b879d4a856a245255f847bb8f3a4e929a6a3d8ba853ba32f607f779eb4269b98d646835a078fc767e11a5d9dde40ab8b697fe43882292976a3182a962bbdd5afe88fb43683c9c7fd31d9c4d48cc6a546f9287c02ae11465f863690dcd29d2fad4db11ac54cb173318df4d256f3f9f38fed846c621a0f0deee1704b493b1a6e7a19b4ec547623068ac928368ad14ac3b4ebaec781ee7c693c36314d8646f8605c3b6a94e3d014e4ab7034eeeace5902d51dda9453b1504c5cac1cc57a3f77ce34199b98a643a3dc135a44e2e7700dd7d16e33d7e164ece8ce3b24d4717b687d06adb4e376da69a2982ab67bbaf3a6e9d8c4341b1aa94615aa8f7ab5b1e8cee7a111891a9ebc2b7afbbb5665c7ced0b7fc6b71135c9d57a2182a969bb96ba4d9d8c4d41e1aee8e38135f856be0abd160a4f7e2a5d06fe42ddc75ba80b26d8e037106de839566e1ad44b152cc06ff44b46c3631b58fc6ac6fc37d703e561b61b81a4d617d37b498a57e3a68efbaddb089bb769bb8c6c6b83f0e851ee5cfc1bbb0d2421be3504c141bc528dfe62f884d4cf34503d71befc3470d7edcaeae71fd10eaa27c0bf453e2afa06f5375ab9d00bd78d4b51f017dd844ffad34fd9bf228af8ed1b1afc39bf171fc33dc35a7a5ba2b06ba76f68c2c814d4c8b45e3df06faf069adba7146baf595eaa63aaaaedbb858a4c5b28969b9f870e84df9d3a0dd6a579adeda752abbeaa0ba6cefea9a96cb26a66ee1c3b3030e867eefeb91f983586d0fc445525934204a653b052aeb0eae2ea95b6c62ea073e64ea6edc1bea32d4d6d66f83363bd1dc784d83d50218ee033b099d43e7ba05eac67b3b5e8e63a16be7e21a3d6613d330f0e154cfc346d05e89ea8fd742a89ad978088e82b6c316fdb7d2f46fcaa3bc5b43c7e61bf901b38929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b08929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a6944af0abdffa0f50331f92e214a57e0000000049454e44ae426082);
INSERT INTO `timages` (`ID`, `EmployeeID`, `ProfilePicture`) VALUES
(18, '1234', 0x89504e470d0a1a0a0000000d49484452000001000000010008060000005c72a8660000000467414d410000b18f0bfc61050000290049444154785eeddd79dc345579e6f10404511601410583208b806322a384650c881a500222226e80022a11414565738b01c7046312d4c1510411c880a0801a9720a21351c495b88119f715351a11354e1c63c6fcaed0a5f5deef55cfd34b7577559dfb8fefe703e73d5575ce5da79faeaeb3fdd6af7ef5ab9452a16c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b08929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b089691876d876bbdfc646d80a3b63773c0487e0283c6344ffad34fd9bf228af8ed1b1bfedce9d86c126a67ee0c3b919f6c631380b6fc3e7f06dfc04ff1fbf9a91cea173e99c3ab7aea16be99abaf666ae6ca91f6c62ea163e643be0609c8cf3f1417c1fee03bb0c2a8bcaa4b2a98c2aeb0eae2ea95b6c625a2e3e3cdbe369b814df81fbd0f581caae3aa82edbbbbaa6e5b28969b1f8706c83a37111be01f7611a02d54d75545db771b1488b6513d37cd1f837c0e1d023f397e13e2cd3f825be84ebf02e5c86f3f0d73803cfc37178020ec2be23fa6fa5e9df94e74fa16374accea173e99c3ab7aee1ae3d0dd55d31502c3670b14af3651353fb68e07a23bfcfa8c1df06f78118d70ff061bc11a7e350ec8af5ddb5dba46b8caea56beada2a83caa232b9b28e4b31516c14a3ec7958109b98da4363de1167e2ab700d7f355fc305780af4d67d73779d2e50d946655459556695ddd569358a9562b6a3bb4e6a8f4d4cb3a1e1aa7bee78dc00d7c05752bd387b2aeeedcedf27d4613be80fc225b805aece2b510c15cbec6e9c039b98a64323dd1357e0e7708dd9f921aec289d8d59d7748a8a3061969f091e234c9cf06c554c7ece9ce9ba66313d3646894fbe15ab886eb68608d1e911f8c627fefaaeef8034cfa5e44b1decf9d334dc626a6f1d0080fc4f5a346b99a7fc73538027772e72b996202f5445c8d717b1a14fb03ddf9d2786c626a4683d3b7d661b811ae514637e1346cedce97d646ac340fe15468e8b18b69a47ba17b92bd0713b289696d34ae7571246e866b84753fc6abf14077ae343e62f880512c155317eb3add1bdda375ddb9d2da6c625a130d6a7f7c01aed1d5fd335e8c4ddd79d2f488e95df0228cf3e250f76a7f779eb4269b986e4723da1a978f1ad54ad475a749301bbaf3a4f628c6782ec6e952d4bdcb9f5e2bb089a5a3d1e871ff24e86dbd6b5895af435d5a7774e749f3a398e3e9586d8095eea1ee65fe2c306c62c968287be153708da9a2474ccd87bf833b475a1cdd033c099f87bb5715ddd3bddc394a66134b44e3d030564d7e5969118defe1c958c79d232d0ff744bd33ea625d69fab4eeadee716787532f9a4d2c0d0d42dfe62bbd5c521ffe39b88b3b3e7507f76813bc0a2b8d25d0bd3ec61d5f1a9b580a1a81de2c5f396a144d3e8a07b8e3537771cfee8fd5e662e8de17fd47dd2696801bafc52fbf326a088ec6e8ff317270494fe9de41ab11a97bd6dd63511bd8dd1d5f029b3874dcf067e3ff8d1a40a4df896fc016eed8d43fdccbbb42f30d9adeefa82d3cdb1d3b743671a8b8c99be2ada39bee68d8eedeeed8d47fbab7a37beceebda86d143588cb260e1137760facb4408556b6b9b33b360d07f758938e3413d3b501511bd9c31d3b44367168b8a11a39f68bd10d8efe054f76c7a5e1e29e6b3314dd7bd726d4569eeb8e1b1a9b3814dc448d16d32212ee268b1e0707bf0847f2b8f7bbe0b3a3b6e0a8ed0c7a94a74d1c026e9cbaf83e30ba91ce85c847fec2d106f493402f085d1b11b5a1c17615dac4bee386693ef967463730fa198e76c7a572d126348df8a7a33612a92d6de58eeb3b9bd867dca89dd0f4b24ff3c5efeb8e4b89b6a1f50a9bbe38d4a67672c7f5994dec2b6e9006f734ed99f7f7c8a1bc6945b411ed88fcde519b89d4b6063568c826f61137e600343dc20dfe654e6a0f6d653dbc69d47622b5b103dc717d6413fb861ba259604ddd7caf41cede4b13a1cd6818b12615b936a5b676843bae6f6c629f7023b49e7ed310cf17bb63521a176de8f9a14d55d4e64e74c7f4894dec0b6e80bef9dd875f53419fea8e496952b4a563f16fa3b655a7b6d7eb27019bd807045ebff9dd63ffffc523dd31294d8b3675f0a86dc5f6a636d8db770236b1eb08b8def6bb177eb7e2bfb963529a95dad6a88dc576a7b6d8cbde019bd865045afdfcaeab4f7f9df3c39fe68a36a619851a4c16db9fda64efc609d8c4ae22c01ae1e706f9e8f7d9c1ee9894da465b3b68d4e6623b54dbecd588419bd845045663fb9b46691deb8e49695e68735a1cd6bd80561bedcd80339bd8350454b3fa9a26f63cdf1d93d2bcd1f64e096db1a2b6da8b816736b16b0866d394de57b9fc292d0a6df02f439bac5ce1f2778d4dec1202a9c53c5c8035543317ec6c406cd6c176f843ec87c3713a5e86a7605fe4b6593322861a3178315c1bedfca22236b12b08a096f1727dfd9aacb19e3ba654c4430df1c1f89fd0b6daff8a1837e736bc13cf8376e2cd61d3132266da9de8dd88b155dbedf4f26236b10b089c16f0746ffcf5926523774c8988853ef88fc1a71163358d1fe1ed780eb4b67e3e658d8138dd199f448ca7da7067171ab5895d40d0dceabd1a70b1b3cb5f1ae2a00ffee3a06ffb18a736697f04dd8be3b1a52b4bba1df1d91e7aa28a317cabcbdf053671d90898d6ed8f4194235dfed21007fdb67f5f2d2e8ba2beefaba12eb04d5cd94a475c1e0b17bb4eee3b60139789406998afdbb4e37c97bf24c440dffada8ebc69dd8345d23b8637637fe4cf841ae2f15ac478a94d776eb8b04d5c1602a4c13e6ebb2eaddc7a27774c29a8bfbef5df3f8ac76ad4d8d417fd2778220e81be9976c3bda08954fa8dff7a28b64dd3a9c7a53dfa5f84ec550071d0b815b7c5bcda76a70609d9c46521386ea34eadddbe8bcb5f02eaae6ffd1330ceb7feb77012267a494afe2da06e42f520acb6cffe4a340dfb1d78248aee4da0fef781bb6757bafccb62139781c0688bee182c39cae52f0175d792d557d562d1e4ebd02698ebbbf34c8af3dc1d4fc0b9f812dc3557f3093cd09dbf14d45feb55b8d874666b729bb868046473b8fdf92f70f94b40ddb5a1e56adb5bebd15d4b9ecdb55b94f3ab3bf02ce851df95a3c9bfe31c14bb182b75d746b3312e6aeb9bbbfc8b6613178d609c570b4e45bbf614f9bb9f7aab3be90ba33834f922f671c7cf13d7dc135a2b6fa52db7a3efe289ee7c4347bdf514e736243dcfe55f349bb84804622fc49750faff2277e9a5de7a4977cb280e8e7e676bfcf952ff38727dbde8d2661ad7c195d3d14bc73bb8f30d1975d61a02ae8defe5f22f924d5c1402b02edcdbd222bbfca8f766d0e625311e152d3ad1b9454f2893f6d83b1b1a34e4ca5df71e6cecce3364d4d96d3fa6b6bfaecbbf28367151a8bcde58c7a0e8d1f2ae2eff9051e70df0c1510c1c3df2efe08eed0acab7315e0d3da5b83a54346cb9a82e43eaab773aee67d3492effa2d8c445a0e25be327b540549ee6f20f1df55e6917e38f620b775c1751564d2afaf8a8ec4df4a4d38917618b427dd55313e3a0cfc0d2fe18dac445a0d297d78250d15befe2469551e7a7d66210f56a85990a65d674e467c1cde6ace80f5b312f7aa9abc674b89e9dcb5dfe45b089f34685357c3406418f8df777f9878c3adf136e0289a87fbfd78fca945fcb69af3435f9b5eeb8a1a2beea52753f91f677f9e7cd26ce1315d58b3fd7c555e4ea3ed45b73f1632c44bf17073102927a3c0c1ad1e9ea298f72c70d15f5755b8ee933b1f0178236719ea8a4ba8e62e5bf83e266975167178bcaa1ee98bea23e5a53bfe949477fec8a7929485d3781da7c8cc3c267bbdac479a182fa0de4bab906b1d1e224a8b35691d1d8fd180bb9d41dd377d44b83889ade095ced8e192aeaeb8609ebb3b1d0776036715ea8dc61b5ca5634f9a4c4177f4df3c6356a6eb06fc7a9db0b6a758df674c70c11756dfa323ccce59f179b382f54eec650597992cb3b74d4fb43210e95c35dfea1a07eea1d681aefd0d99573e681faba9f8037babcf36213e7818a1d182a2a9a5c52e2d050f593c758885e040dfe69883a6e0bb7d1a6260f15b3e41b75d50bf12f8fea5e77a0cb3f0f36711ea8d4f5a192f2749777e8a8f745210e9567bafc43445d35d5d8c5e05c977fa8a8af1b1c74bdcb3b0f36b16d5448ebd2c74a6ac24b2f764f6993ea0cd725a637e4c5ac764c5d77469c2023df71f9878afaae876fd6ea5fd9cfe56f9b4d6c1b95b936544e3abf69c23c506ff589c758c8d92eff9051e7a63110bfebf20f15f57d66a8bf5cebf2b6cd26b6898aa8eb27564e0b226ce8f20f1df57e692d0e750f76f9878c3a6b3f03178b935dfea1a2be9a08f6bd5afd2b73ef15b1896da2126e92cb8b5cde1250f74b432c448b786ee0f20f1975deb21683ba6b5cfe21a3cea78618c8dcf717b4896da1029adffef35a85e4c7287989283719e44b2e6f09a8fb3f8658c8f75cde21a3ce1b21aea7a0cfce662e7f5b6c625b28bc7693a957485eedf29682fa6ba04f8cc9fb5dde125077ad1214e321c56dff469d5f116220c7bbbc6db1896da1f0eedbaed89562a9bbdef8ba37df17b9fc25a0eeda9f20c6437673f9878c3adf2fc4406e7079db6213db40c1770c15919b5cde52507f2d101963227feef29780ba3f3ec4a2f218977fe8a8f73f8438c88e2e6f1b6c621b28f499a112729acb5b0aeaaf1d64634ce4652e7f09a8fb3e211695e35cfea1a3deee89e84c97b70d3671561458131de21af21ae659f4d651d47fc35a3ceafec2e52f0175d70e3a2e2647bbfc4347bdb5298b3661adc7429fa5b90c11b789b3a2b0eeaf7a715d3b1131d0a299312e52dc20a00a7577bf7ba5c87d0484babf3bc442e6b207844d9c1585754b201737e73f22065a0822c6455ee3f29780ba6ba110179322df01087577ef45e6b254be4d9c0505d5a8a6b8f28b563e2d7a775f2106dafdb81e97caeb5dfe125077374b541ee9f29780baeb33a4f132f578e833d5fa60319b380b0aa95d66eb059762f7f8ab230e9a0b1f7fdfc9852e7f09a87b532fc0c35dfe52507fb7a760eb6b45d8c4595048f7f85fdc38f726c4e2db2136f2772e6f09a8fb1f8758541ee2f29782faef1be221adff0cb089b3a0907181030d6f2c6ec9af26c4e263b5d8546e76794b40dd4f09b1a83cc8e52f05f5574f5a1c1afc1597771636715a14709b5060b9cae52d15f1785b888ffcd4e52d0175ffef2116959d5cfe921083ab424c645b97775a36715a14eee8505839d1e52d15f1d07efe314652dc7e8842bddd6c512d17b68ecb5f126270622d2695635dde69d9c4695138b7d4d5ae2e6fa988c70b437c2a0f70f9878e7a6bf7a3188b4fbabca5210ebb86b8c8252eefb46ce2b428dc3742618b5ade691cc4e49810a3caa35dfe21a3ce770b31a814db2b12118bb881c82d2edfb46ce23428d8f6a1a032c80d2e66414cdcbe88f21c977fc8a8b3f60d74b1286a45a095100bb7804c6b5bc6d9c4695028b7bae9535dde921193fb8618555ee9f20f19757613c6e40097bf44c4c2ed1c7d82cb3b0d9b380d0ae5fe52dddbe52d1931392ec4a8b2b42da297853aff5d8841e51e2e7f8988c5bd436ce44a97771a36711a142afe56f99acb573262a20541dc4b2f39c71d3364d4f933210695fbbafca5221e5f0bf1d166aaad8cadb18993a2303bd40a57c9e1bf01313936c4a8a24541f772c70c1975bea41683ba97b8fca5221e1784f8482b7f246de2a4288c7b99f31497b764c4a46947a0935cfea1a3de3be197b538543ee5f2978a78b82f8e56664bdac44951989343e1646f97b764c4e413214695ed5cfe125077b72af0cf5cde52118fbd427ce4852eefa46ce2a4288c9b0034d82daea7454c7e1a62244a2b76ae0475bfbc168bbae2f64968422cb4bc7e8ccfc52eefa46ce2a4284cdceef9072e5fe9888bd645a8c7493ee2f29682faff658847652b97bf54c4e39f427c5a693736715214e6fba1701f76f94a475ce2484959d84eb05d44fddd84975f603d97bf54c4e3ba5a7ce456976f5236711214c43d9ebcd1e52d1d71f9548893dce6f29682fa7f3ec4438a9d1edd84989c1762245bbabc93b08993a0107b8742c9e92e6fe9884bd3c097df71f9878e7adf01fab68ff1788bcb5f3262f2bc10239979cd049b38090ae126b71ceaf2968eb89c11e25439d0e51f3aeabd4b8843e50c97bf64c4e48f428c64e6ae769b38090a71562894e4146083b83c3cc4a972aacb3f74d4fbd1210e95c7bafc2523266eb0ddccfb49d8c4495088b8c28d0676aceff2968eb86c0ab7376091b326a977d3da0839143820265a5036eeb4fd7697771236711214e273a150c56e753d0ee2e35e7a7d0fc58d05a0ceefacc5a0923d000d884bfcac7dcee59b844d9c048588abdc5ee7f2a5db119fa625c18ada0d97fa6aa3542dfd15e370a3cb9ffe3366d784587ddbe59b844d9c048588835bdee5f2a5db119f478578555ee5f20f15f53d2ad4bf52ec4ec9ab213671ccc44f5cbe49d8c47151002d5d1c7fd35ee6f2a6db111fed0ee426c068f3d43ddd3143433db501e60f46f58e720f8906c4e6e2102bb599997e3adac47171f18d6a85a99ce7f2a6df20466f0f31ab14f1f84b3d9ba601eb5d48fefe6f406cdccfc78d5cde71d9c47171f1ad4261e4af5ddef41bc4485b62bb013032e83101d46f5bb8272079b23b26dd8ef8bc3cc44b669a336113c7c5c5770e85911cc43106e27476885be5752eff50503fb7d6bd5c8fdc416a05c4e7c5b57855767679c76513c7c5c5770f8591e7b9bc694dc4497328dc5bf099bb76ba8cfab9c93fb2bbcb9f7e83189d14623673dc6ce2b8b8f8434261e4389737ad8d58bd3fc44ef452753397bfefa897dbef4ebeeaf2a7351127b742f04c9ba8dac47171f1434261e4092e6f5a1bb17a49885de52097bfefa8d76ea19e95735dfeb426e2f4b8103739c4e51d974d1c1717777db9836cbcf340acf60bb1abbcdce5ef3beae566b4492bebdb0d1d717213828e7279c76513c7c5c59f110a23fbbabc696dc46a036845e018c38fbafc7d47bde2ca51a21e8141fee4691b71dab716b7ca335cde71d9c471e9e2a130927f002640bcdc87425adbfea90ba8cfef86fa5506f9c76e1e8855e7fe00b89f0007bbbcc9235ecf0af1ab9cedf2f715f53937d4af52dc9e88d322560785d8c9527f02b897804f74799347bcee0af73340bbbfdcd11dd337d443c39fff6554af3a7583e6e3ff9888d5136ab1ab2cf525a0eb067cbacb9b9a11b3a6bef1235dfebea11eaeff5a2e72f99347bcdcbe924bed067403818a5cdd6616c4ec91218695de4fada60eebe28bb53ad51531f9a92dc4ebb9217eb2d481406e28f04b5dded48c9869714c4d8489b1945e7f4828ff09a13e95dcfe6b42c4cc8d1b59ea50603719a8a879ed6d216ecf0f71ac7c04bd1c234fb937871bf92747b863523362e6365159ea6420371d3877059e0271bb33e216eb955e7e5828f76b433d2ada233127fe4c8898b99e94a54e07760b825ce1f2a6d5113b37ae42be853bbb63ba8af2fe1e9aa6fdeee38e492b236e9786382e774110a1007149b06b5cbeb43a62b71ebe528b65dd9fba63ba88b2ea8be103b5b2d7bdd51d935647ecde1162b9dc25c18442c445416f70f9d27888df91219e959fe13eee98aea19c2fa895bb4e8ba0ece48e49ab23767f5f8ba5746251d0b854f1575cbe341ee2a76f4f374d5814eb4eff14a07c7f88a647ff5cf07306c4efe610cf4e2c0b1e3706d1ef92418c605b16e2a765b3dc56e2f237ee982ea06cdba069b14fbdf8cbf5fea644ec349e228e18edc4c6206e6bb0fbb9bc697cc4f06921a675c7bb63968932ad8f8fd5ca58f753e4a3ff0c889fd6918c71edc4d6606e73d0c35dde3419e27875886b455b447566092dcaa29f2d6f1c95cd39d61d97c6470cdd7e129dd81cd46d0ffe6297374d8638de13b7d6e25aa79183ffc51db74894417bd65d382a93935b7db78038ba81629dd81e5c8b5bc68215b9d9e53c10cbeb426cebf47b7b695b8a716d0d61be6c541647ef83eeee8e4d93218e17d5e25ad9d2e59d844d9c1405f97e2858eeefd602e2784088aba32784df77c7cf13d7d46ffef802d879a83b3e4d8638c6f72bb7ba7c93b28993a23071551bcdfdcea19e33207e1a47af1180f5b836f931fec09d671eb896d63078cfe8daabd1f0e6addd79d2f88861ec15fa88cb37299b38290a737e289c6ce3f2a6d511bb5df18fb5588e43836cf43b711d77ceb670fe83f15db83234f914b673e74bab23767a1714637ab1cb3b299b38290a7372289ceceff2a666c44c7dbd4f47d31800893fb7223d8db5fe61e39c9b60a537fdabf91172f5df2910370dae8af17ca1cb3b299b38290aa36f8558c067b9bcc9235e07e2a65afc9c2ba15983ab7d10f507e458ccfc338c73e82dbfbaa0be0177ad8ade45dc16d21c6d8c3ad31cf6d2102fb76e642b7f4c6de2a428cc0ea17072a1cb9bd6449c346beebdb5b835792bee503b4eabc3340db9ad68251e359e8debd71c07c76c81d3f055b873d76994dff6d05382e6acc719a2d1bf415385efe6ae9dd6449c5c37eb7d5dde49d9c46950a03897fd5b2e5fba1df1b9172e80bacaea7173f4adb9d6305ad21e0e3d5abb63eaf492f095d8137789e7199d4b5d7afa43aecd27fe061a6ce4ce15e9bceb8773a9f7a26985a33a3da968cbebff5a3f3ead89f8c497c15a30b69597ec36711a1428ce559641ad6ddf0662a28554b508e86adfde157d181bc7d0f36f1a22fa7f4679c7f54fd0bb828ba1d1865f82be955dde265ae9a771455afeedee18b7a740fe017aff914f0535c4c32dbb77a5cb3b0d9b380d0ae5c6aee77b0010870da1c61d674eae44eb028cb5e433f9b43293f68e77cb8bcfc3bbb16a2f0f79344458ef22c6791aa8e80fa3fe28695af486eebc2521066e3bf5135cde69d8c4695028fd068c057d87cb5b0aeaaf47eab331ce637a456be5ff093670e75c09c7e87a7f0b77de367c0813afe6c331fab97309567b3710693c899e52f670e72d01757783ad5a7bb2b689d3a260f14db17ee3fdfac55509a8af06f068fdf6ff8d491bbc7e1a6cebce3b09cea1dfe0ea7b77d798c6a7f147ee5a93e01c0fc0fb46e79cd4c7f1641433d59cbaaa5b387e79dce2f24ecb264e8bc2b9f1ca334f58e83aeaa847703db2be0b1a901363b01af502b43e6496736a3f3efd3458ad0bcff93cfe0cad0f33e69c0fc51598e6278bc641fc39eee5ce3d24d4718f519deb2e7179a76513a745e18e0e8595335cdebea35e77c4a3f166e8b13dd67b35ff8a3760ee6b27700dfd16df07fa69a19e077d0b7f192a837e9fdf887742abce6a50d742fae9b98eba1ad59df959b818ad44ef0ad435aaf11313ff5cea03eaf542c47ab73ab5da264e8bc269459858e0eb5ddebea23e9afd78069ad6bb5f8d86d1ea8338f34cae21211e1a0ff10a8c3bffa14edd6267625031a53efa1919eb3af34fc43a9b380b0aa86f967a81d5bdb489cbdb27d441dd5a7f819586e936d1b795bac4f433618d3ef3b426e2a3a795fdf0264cfa13414f62afc3bdddb9fb843adc09712c46ebeb6ddac4595048373168a61d4c9789b26f8a57639ac7fc8f4223f1b26f7b0ac44d7f745f8c499f0af4d3464f69bdfd6940d9dd54f0f35dde59d8c45950c8c343a1a5d517178b42b91f84afd7ea310e0dcad11e6e3bb873a6c9114b8d523c0cee9178251a4bf10877ceaea3dc7a3f14ebd3fa527b367116147203c44921faf6eccdcf00caaa0930fa9d3eee683d0d83567fff03ddf9527b88b1a64a6bf8b08637bb7b11a92bf639ee5c5d457935702cfed4d467aaf5271a9b382b0aea7e061ce7f2760de5d41fb06b6ae56ea286a59d5a345573ae73f0d3da88b976517a04ae85bb3f912629f562911acae97ad35a7ffc179b382b0aab2ea75881ceef184419b5cc55d34abc15bdd4fc5fc8a5cf3b827bb13b34ae60b589559aafd2f997b094d1ad033997fd146de2ac28acdee4ba69a49d9d074ed9f43b53b3ee6299eb3e8c5e6ccf5522ee8d063e696ab2bb77158d81b8933bbe0b289b8673c711a4fa2ccde5e9c526b68102ab5fb65e0939cbe5ed02caa62ebe58de8aba634e453eea771cf7487fc8358066a52ec457ba63bb80b2bd2c9455ce7479db6013db40a1770c95905bb0aecbbf4c9469273435184d48d9cf1d97ba8b7bb62f9ac66ce8675c2b0b6ab48932e9e5b3ebf2dcd1e56f834d6c0b05bf2154440e7479978932c56d972b6a40839fcb3054dcbbdf47d388cdf7b96396893269819758ceb9be3bb3896da1f0c787cac89b5dde65a13c4d6befeb85d2c296da4ef3c13ddc0b4db3320f73c72c0be5b93c944fe6ba0fa44d6c0b85d7b8f9389c51ffbf99cbbf6894432f2b9b26a2bcc11d93fa877be966a98a86ad77e2bd0ee558ca67c526b6890aa87ba65e2939c5e55d34caa19964b16ca247ff7bb86352ff702fb782762876f7ba134f0194e394502eb9c2e56d934d6c1395d04294b1625a936ee9cb3d5186a6c5299eeff2a7fee29ebaa9b5b2f4d9aa944123fff4998865dbd3e56f934d6c1b1571a3b54e75791785ebef16ca53f91a8a5975a614dc538df06c5a1865e17b2bd6717d7531c7325debf2b6cd26b68dca687a67aca0567659da5300d7d668be5826c9854c078a7beb3e687299cbbf085c5bdffe6eb7a785743ddbc479a042d7870acae92eefbc71ddbbc0f5fbabcfdfae9b9ffa8f7bab4d4de38b36515b58ca6435ae7b7aad1c9585fd2cb189f340a5dc0b37ed6fbf91cb3f4f5cf3885a19ea5eeff2a7e1e01e6b9f0577ef9fe8f2cf13d7d45a92fa0cc4b22c6cac8c4d9c172aa6b5e762655fe0f2ce13d7743d13727f973f0d07f778ef70cf2b6f71f9e7896bbe2094416e7479e7c526ce0b95d3a20eb1c25acf6de2bdeba6c5b5f432488ffab11c1f76f9d3f070afdd92e9ea265cd80a425c6b63a8edc7722cb45bd226ce0b95d3c09b9b6b95adb4b2d5f138b8d621e1da95135dfe343cdc6bf7cd2b07bbfcf3c0b55cb7a43e1b0b5db3c026ce1315d4c298b1e21aafbd90a700aee3765a955cc2ab10dceba62ee00b5cfeb6711d7dfbbb390a47bafcf36413e7894a6ab7932fd42a5d7985cbdf26aea16bbbc7ae2fbafc69b8b8e79a991adb815ec8cd7db62ad7d0f2e7f1dafa4c2c7ca6ac4d9c372aba7fade2154dd1dccde56f0be7d7cebcf1baf23f5cfe345cdc736d90e2dac2835dfeb6707e3d7db89d980f70f9e7cd262e021576339f3e89b9fd15e4dce7d4ae5537f3be77a95fb8e78f096da0f22a97bf0d9c5b4fa06ec5a285f740546ce22250e9ade1166c789ecb3f2bceab17906eb105ad21dfd925a2d27c70cf3781fb26fe86cbdf06cefd9c702d51efc33d5dfe45b0898b42c54faa05a2a22ebaed5cfe5970ce07d6ae51778dcb9f868f7bff81d0162aadff14e59cda22ddcd483cd9e55f149bb828545e8f44ae4ff66a977f169cf3d9e11a955ead199fdac3bd3f2db485ca092eff2c38a7768e8ed7d15a144bdd3edf262e1201685ab1e508977f5a9cef9270feca2e2e7f1a3eeefdfd425ba85ce8f24f8bf33d2e9c5fd4e697bee2944d5c3402715e2d3015cd90dadce59f06e7725d8f5f737953396803df0c6d426e7279a7c1b9b4b7a476848ed7b8c8e55f349bb868046373b84911adfc25e63cba09ee29e3752e7f2a076de0f5a14d88d6836c65921ae7715f6eb7a2135b99dbc4652020c7d4025437f3cc28cea1edbbdcb95bdf6c31f50b6de0f1a14d54661e0fc039d4eedc17cf5c17fa9c844d5c16027365089468c8e44cfbbd737cd37250735b6f3df5036d6097d0262a33ad5bc9f17aebef9e6ab5047d67f628b489cb4260b45087b6748e41fb34eeec8e1907c7bead76aecacf903bfd148e36a09e288d0589ed63eac1391cab19a76eeabb96246bedbd561b6ce23211206df4e856ebb9d4e51f07c7ba71df1f77795379680b1a811adbc7d42f8839f6e2702ef905f672f997c9262e1b816aadcf9e6334e2d09d2bd7fd4fff89b6f0c6d0362a13bfa8e39867857354963ae0a7894dec0202f6d61040d1d0cd895ece90ffd0daf17527b9fca93cb485e786b65199688e08f9b52dbe1b5efcb72e7f17d8c42e2068eabad312dd31985a3ffd77dc310e79ffac766cdd435dfe541edac2c342dba8bcc4e577c87b4f7caf766ce5ebe8c44e588e4dec0a02b707f4db2906f5e3186bed7ef2b99e05d9c2e54fe5a12d6c19da46e54d2e7f44be3be263b5e32a6abb73dfdc631636b14b0860d3e3d958bfe1c9e7e61a7cd7e54de5529b086d443ee6f246e43b3f1c5799cbccd636d9c4ae21904dabf89ee6f2d791c74d397eafcb9bca459bb826b411f9a1cb5b479ea6094573dfd7af0d36b16b08a61eb19aa66e36f60cf06f4d8f767fe5f2a772a94d843652d9d4e517fecdcdef17b5d55e6c2f6713bb88806a90d06746018eecf44dd235d3d0e53fdae54fe5a24d3c39b491caee0df94f08f92a6aa3bdd95dca26761581d536cfae6740e3ad8f33f9dd0ac4b2f46998a95b68130f0a6da4f20493f738b831fe6a9b5bc5fc5d6613bb8c00ef04b799a26ec83121ef4b6aff5e77af7abe946813db8436527951c8a7496beec3af36b9533d6f1fd8c4ae23d01a2eec9657d234ce5f2f24c27f5f54fbb7ca2fb1f0e59753b7a94dc00de2f9f59474fe5b7b4aaa8dc53c6a8bf6a742d7d9c43e20e007c08d11d007fcb1a33c1faaa557e6b6e863ea37b58dd056e483a37f7b2cd4b6e2bfab0d2e6549ef36d8c4be20f0fa8bec1ec7f497fcd1f84e2dadf22177ae94d436425b11b521b525f774a0b6d7ead2758b6613fb841b70e2e846c49be39e0e64ea598569d8d436425ba9b8b6a436d7fbfd246d62df7023f424d0f4818fce72e748496d23b495266a6bbdfee6afd8c43ee286e89d807b31183dc31d9f92da46682b8eda586f7ff34736b1afb831ea1d705d8475b90d58b2681b0785b612a96df5f26d7f139bd867dc208d137083852a390d3859b48dfd425ba9539bea5d3fff6a6c62df71a33462b069d8b02607ad35ba2b958d3671187e346a2391da52af46f88dcb260e01374c73079a261089d66bcf4d410b471bd044b3d78cda84a336d49bb1fd93b28943c18dd3cd6d9a4a2c9fc3aeeed8347cdcfbfb402b4ebbb6216a3bbd98d5372d9b3834dc442d2ad2d44da8dd88d7984390868f7bfe2434f51aa9ad3cd71d3734367188b8a15a5e6ca597835aca7943776c1a0edd63b8392215b5913ddcb1436413878a1bab8546dd6ac3952fe161eed8d47fbab7a37beceebda86d342e0032443671e8b8c9da77c06d3e52d156e27773c7a6fed1bd1cdd5377af456de1d9eed8a1b38925e0866bd090db86aca21d5c9f8eceece39626a37b37ba87ba97ee1e8bdac0a006f74cc22696821bafaec2a665c32b37e0f7dcf1a9bb74cf46f7ceddd38aeefd60bbf8c661134b4323d02a2f2b0d21d654d057205f12769ceed1e85eb9e9bb15edda9b3d3fb08925a2416c8673e1567ca9686eb8de1f6ce0ce919647f764746fdc1a10154de1d500b04eedd0bb4c36b164340e7517baad9debbe0dad4330e841227da07b30ba17ba27ee5e55b4414ce776e75d369b583a1a8ad6877b266e836b4c956fe278acefce93e647311fc55ef7c0dd9b8ae67e9c845c07d2b089e976349a7b60a5eea38a3680d452d1ebb9f3a4f628c6a3582be6ee5ed45d8eaddd79d2ed6c625a138de821b879d4a856a245255f847bb8f3a4e929a6a3d8ba853ba32f607f779eb4269b98d646835a078fc767e11a5d9dde40ab8b697fe43882292976a3182a962bbdd5afe88fb43683c9c7fd31d9c4d48cc6a546f9287c02ae11465f863690dcd29d2fad4db11ac54cb173318df4d256f3f9f38fed846c621a0f0deee1704b493b1a6e7a19b4ec547623068ac928368ad14ac3b4ebaec781ee7c693c36314d8646f8605c3b6a94e3d014e4ab7034eeeace5902d51dda9453b1504c5cac1cc57a3f77ce34199b98a643a3dc135a44e2e7700dd7d16e33d7e164ece8ce3b24d4717b687d06adb4e376da69a2982ab67bbaf3a6e9d8c4341b1aa94615aa8f7ab5b1e8cee7a111891a9ebc2b7afbbb5665c7ced0b7fc6b71135c9d57a2182a969bb96ba4d9d8c4d41e1aee8e38135f856be0abd160a4f7e2a5d06fe42ddc75ba80b26d8e037106de839566e1ad44b152cc06ff44b46c3631b58fc6ac6fc37d703e561b61b81a4d617d37b498a57e3a68efbaddb089bb769bb8c6c6b83f0e851ee5cfc1bbb0d2421be3504c141bc528dfe62f884d4cf34503d71befc3470d7edcaeae71fd10eaa27c0bf453e2afa06f5375ab9d00bd78d4b51f017dd844ffad34fd9bf228af8ed1b1afc39bf171fc33dc35a7a5ba2b06ba76f68c2c814d4c8b45e3df06faf069adba7146baf595eaa63aaaaedbb858a4c5b28969b9f870e84df9d3a0dd6a579adeda752abbeaa0ba6cefea9a96cb26a66ee1c3b3030e867eefeb91f983586d0fc445525934204a653b052aeb0eae2ea95b6c62ea073e64ea6edc1bea32d4d6d66f83363bd1dc784d83d50218ee033b099d43e7ba05eac67b3b5e8e63a16be7e21a3d6613d330f0e154cfc346d05e89ea8fd742a89ad978088e82b6c316fdb7d2f46fcaa3bc5b43c7e61bf901b38929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b08929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a6944af0abdffa0f50331f92e214a57e0000000049454e44ae426082),
(19, 'OSS1', 0x89504e470d0a1a0a0000000d49484452000001000000010008060000005c72a8660000000467414d410000b18f0bfc61050000290049444154785eeddd79dc345579e6f10404511601410583208b806322a384650c881a500222226e80022a11414565738b01c7046312d4c1510411c880a0801a9720a21351c495b88119f715351a11354e1c63c6fcaed0a5f5deef55cfd34b7577559dfb8fefe703e73d5575ce5da79faeaeb3fdd6af7ef5ab9452a16c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b08929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b089691876d876bbdfc646d80a3b63773c0487e0283c6344ffad34fd9bf228af8ed1b1bfedce9d86c126a67ee0c3b919f6c631380b6fc3e7f06dfc04ff1fbf9a91cea173e99c3ab7aea16be99abaf666ae6ca91f6c62ea163e643be0609c8cf3f1417c1fee03bb0c2a8bcaa4b2a98c2aeb0eae2ea95b6c625a2e3e3cdbe369b814df81fbd0f581caae3aa82edbbbbaa6e5b28969b1f8706c83a37111be01f7611a02d54d75545db771b1488b6513d37cd1f837c0e1d023f397e13e2cd3f825be84ebf02e5c86f3f0d73803cfc37178020ec2be23fa6fa5e9df94e74fa16374accea173e99c3ab7aee1ae3d0dd55d31502c3670b14af3651353fb68e07a23bfcfa8c1df06f78118d70ff061bc11a7e350ec8af5ddb5dba46b8caea56beada2a83caa232b9b28e4b31516c14a3ec7958109b98da4363de1167e2ab700d7f355fc305780af4d67d73779d2e50d946655459556695ddd569358a9562b6a3bb4e6a8f4d4cb3a1e1aa7bee78dc00d7c05752bd387b2aeeedcedf27d4613be80fc225b805aece2b510c15cbec6e9c039b98a64323dd1357e0e7708dd9f921aec289d8d59d7748a8a3061969f091e234c9cf06c554c7ece9ce9ba66313d3646894fbe15ab886eb68608d1e911f8c627fefaaeef8034cfa5e44b1decf9d334dc626a6f1d0080fc4f5a346b99a7fc73538027772e72b996202f5445c8d717b1a14fb03ddf9d2786c626a4683d3b7d661b811ae514637e1346cedce97d646ac340fe15468e8b18b69a47ba17b92bd0713b289696d34ae7571246e866b84753fc6abf14077ae343e62f880512c155317eb3add1bdda375ddb9d2da6c625a130d6a7f7c01aed1d5fd335e8c4ddd79d2f488e95df0228cf3e250f76a7f779eb4269b986e4723da1a978f1ad54ad475a749301bbaf3a4f628c6782ec6e952d4bdcb9f5e2bb089a5a3d1e871ff24e86dbd6b5895af435d5a7774e749f3a398e3e9586d8095eea1ee65fe2c306c62c968287be153708da9a2474ccd87bf833b475a1cdd033c099f87bb5715ddd3bddc394a66134b44e3d030564d7e5969118defe1c958c79d232d0ff744bd33ea625d69fab4eeadee716787532f9a4d2c0d0d42dfe62bbd5c521ffe39b88b3b3e7507f76813bc0a2b8d25d0bd3ec61d5f1a9b580a1a81de2c5f396a144d3e8a07b8e3537771cfee8fd5e662e8de17fd47dd2696801bafc52fbf326a088ec6e8ff317270494fe9de41ab11a97bd6dd63511bd8dd1d5f029b3874dcf067e3ff8d1a40a4df896fc016eed8d43fdccbbb42f30d9adeefa82d3cdb1d3b743671a8b8c99be2ada39bee68d8eedeeed8d47fbab7a37beceebda86d143588cb260e1137760facb4408556b6b9b33b360d07f758938e3413d3b501511bd9c31d3b44367168b8a11a39f68bd10d8efe054f76c7a5e1e29e6b3314dd7bd726d4569eeb8e1b1a9b3814dc448d16d32212ee268b1e0707bf0847f2b8f7bbe0b3a3b6e0a8ed0c7a94a74d1c026e9cbaf83e30ba91ce85c847fec2d106f493402f085d1b11b5a1c17615dac4bee386693ef967463730fa198e76c7a572d126348df8a7a33612a92d6de58eeb3b9bd867dca89dd0f4b24ff3c5efeb8e4b89b6a1f50a9bbe38d4a67672c7f5994dec2b6e9006f734ed99f7f7c8a1bc6945b411ed88fcde519b89d4b6063568c826f61137e600343dc20dfe654e6a0f6d653dbc69d47622b5b103dc717d6413fb861ba259604ddd7caf41cede4b13a1cd6818b12615b936a5b676843bae6f6c629f7023b49e7ed310cf17bb63521a176de8f9a14d55d4e64e74c7f4894dec0b6e80bef9dd875f53419fea8e496952b4a563f16fa3b655a7b6d7eb27019bd807045ebff9dd63ffffc523dd31294d8b3675f0a86dc5f6a636d8db770236b1eb08b8def6bb177eb7e2bfb963529a95dad6a88dc576a7b6d8cbde019bd865045afdfcaeab4f7f9df3c39fe68a36a619851a4c16db9fda64efc609d8c4ae22c01ae1e706f9e8f7d9c1ee9894da465b3b68d4e6623b54dbecd588419bd845045663fb9b46691deb8e49695e68735a1cd6bd80561bedcd80339bd8350454b3fa9a26f63cdf1d93d2bcd1f64e096db1a2b6da8b816736b16b0866d394de57b9fc292d0a6df02f439bac5ce1f2778d4dec1202a9c53c5c8035543317ec6c406cd6c176f843ec87c3713a5e86a7605fe4b6593322861a3178315c1bedfca22236b12b08a096f1727dfd9aacb19e3ba654c4430df1c1f89fd0b6daff8a1837e736bc13cf8376e2cd61d3132266da9de8dd88b155dbedf4f26236b10b089c16f0746ffcf5926523774c8988853ef88fc1a71163358d1fe1ed780eb4b67e3e658d8138dd199f448ca7da7067171ab5895d40d0dceabd1a70b1b3cb5f1ae2a00ffee3a06ffb18a736697f04dd8be3b1a52b4bba1df1d91e7aa28a317cabcbdf053671d90898d6ed8f4194235dfed21007fdb67f5f2d2e8ba2beefaba12eb04d5cd94a475c1e0b17bb4eee3b60139789406998afdbb4e37c97bf24c440dffada8ebc69dd8345d23b8637637fe4cf841ae2f15ac478a94d776eb8b04d5c1602a4c13e6ebb2eaddc7a27774c29a8bfbef5df3f8ac76ad4d8d417fd2778220e81be9976c3bda08954fa8dff7a28b64dd3a9c7a53dfa5f84ec550071d0b815b7c5bcda76a70609d9c46521386ea34eadddbe8bcb5f02eaae6ffd1330ceb7feb77012267a494afe2da06e42f520acb6cffe4a340dfb1d78248aee4da0fef781bb6757bafccb62139781c0688bee182c39cae52f0175d792d557d562d1e4ebd02698ebbbf34c8af3dc1d4fc0b9f812dc3557f3093cd09dbf14d45feb55b8d874666b729bb868046473b8fdf92f70f94b40ddb5a1e56adb5bebd15d4b9ecdb55b94f3ab3bf02ce851df95a3c9bfe31c14bb182b75d746b3312e6aeb9bbbfc8b6613178d609c570b4e45bbf614f9bb9f7aab3be90ba33834f922f671c7cf13d7dc135a2b6fa52db7a3efe289ee7c4347bdf514e736243dcfe55f349bb84804622fc49750faff2277e9a5de7a4977cb280e8e7e676bfcf952ff38727dbde8d2661ad7c195d3d14bc73bb8f30d1975d61a02ae8defe5f22f924d5c1402b02edcdbd222bbfca8f766d0e625311e152d3ad1b9454f2893f6d83b1b1a34e4ca5df71e6cecce3364d4d96d3fa6b6bfaecbbf28367151a8bcde58c7a0e8d1f2ae2eff9051e70df0c1510c1c3df2efe08eed0acab7315e0d3da5b83a54346cb9a82e43eaab773aee67d3492effa2d8c445a0e25be327b540549ee6f20f1df55e6917e38f620b775c1751564d2afaf8a8ec4df4a4d38917618b427dd55313e3a0cfc0d2fe18dac445a0d297d78250d15befe2469551e7a7d66210f56a85990a65d674e467c1cde6ace80f5b312f7aa9abc674b89e9dcb5dfe45b089f34685357c3406418f8df777f9878c3adf136e0289a87fbfd78fca945fcb69af3435f9b5eeb8a1a2beea52753f91f677f9e7cd26ce1315d58b3fd7c555e4ea3ed45b73f1632c44bf17073102927a3c0c1ad1e9ea298f72c70d15f5755b8ee933b1f0178236719ea8a4ba8e62e5bf83e266975167178bcaa1ee98bea23e5a53bfe949477fec8a7929485d3781da7c8cc3c267bbdac479a182fa0de4bab906b1d1e224a8b35691d1d8fd180bb9d41dd377d44b83889ade095ced8e192aeaeb8609ebb3b1d0776036715ea8dc61b5ca5634f9a4c4177f4df3c6356a6eb06fc7a9db0b6a758df674c70c11756dfa323ccce59f179b382f54eec650597992cb3b74d4fb43210e95c35dfea1a07eea1d681aefd0d99573e681faba9f8037babcf36213e7818a1d182a2a9a5c52e2d050f593c758885e040dfe69883a6e0bb7d1a6260f15b3e41b75d50bf12f8fea5e77a0cb3f0f36711ea8d4f5a192f2749777e8a8f745210e9567bafc43445d35d5d8c5e05c977fa8a8af1b1c74bdcb3b0f36b16d5448ebd2c74a6ac24b2f764f6993ea0cd725a637e4c5ac764c5d77469c2023df71f9878afaae876fd6ea5fd9cfe56f9b4d6c1b95b936544e3abf69c23c506ff589c758c8d92eff9051e7a63110bfebf20f15f57d66a8bf5cebf2b6cd26b6898aa8eb27564e0b226ce8f20f1df57e692d0e750f76f9878c3a6b3f03178b935dfea1a2be9a08f6bd5afd2b73ef15b1896da2126e92cb8b5cde1250f74b432c448b786ee0f20f1975deb21683ba6b5cfe21a3cea78618c8dcf717b4896da1029adffef35a85e4c7287989283719e44b2e6f09a8fb3f8658c8f75cde21a3ce1b21aea7a0cfce662e7f5b6c625b28bc7693a957485eedf29682fa6ba04f8cc9fb5dde125077ad1214e321c56dff469d5f116220c7bbbc6db1896da1f0eedbaed89562a9bbdef8ba37df17b9fc25a0eeda9f20c6437673f9878c3adf2fc4406e7079db6213db40c1770c15919b5cde52507f2d101963227feef29780ba3f3ec4a2f218977fe8a8f73f8438c88e2e6f1b6c621b28f499a112729acb5b0aeaaf1d64634ce4652e7f09a8fb3e211695e35cfea1a3deee89e84c97b70d3671561458131de21af21ae659f4d651d47fc35a3ceafec2e52f0175d70e3a2e2647bbfc4347bdb5298b3661adc7429fa5b90c11b789b3a2b0eeaf7a715d3b1131d0a299312e52dc20a00a7577bf7ba5c87d0484babf3bc442e6b207844d9c1585754b201737e73f22065a0822c6455ee3f29780ba6ba110179322df01087577ef45e6b254be4d9c0505d5a8a6b8f28b563e2d7a775f2106dafdb81e97caeb5dfe125077374b541ee9f29780baeb33a4f132f578e833d5fa60319b380b0aa95d66eb059762f7f8ab230e9a0b1f7fdfc9852e7f09a87b532fc0c35dfe52507fb7a760eb6b45d8c4595048f7f85fdc38f726c4e2db2136f2772e6f09a8fb1f8758541ee2f29782faef1be221adff0cb089b3a0907181030d6f2c6ec9af26c4e263b5d8546e76794b40dd4f09b1a83cc8e52f05f5574f5a1c1afc1597771636715a14709b5060b9cae52d15f1785b888ffcd4e52d0175ffef2116959d5cfe921083ab424c645b97775a36715a14eee8505839d1e52d15f1d07efe314652dc7e8842bddd6c512d17b68ecb5f126270622d2695635dde69d9c4695138b7d4d5ae2e6fa988c70b437c2a0f70f9878e7a6bf7a3188b4fbabca5210ebb86b8c8252eefb46ce2b428dc3742618b5ade691cc4e49810a3caa35dfe21a3ce770b31a814db2b12118bb881c82d2edfb46ce23428d8f6a1a032c80d2e66414cdcbe88f21c977fc8a8b3f60d74b1286a45a095100bb7804c6b5bc6d9c4695028b7bae9535dde921193fb8618555ee9f20f19757613c6e40097bf44c4c2ed1c7d82cb3b0d9b380d0ae5fe52dddbe52d1931392ec4a8b2b42da297853aff5d8841e51e2e7f8988c5bd436ce44a97771a36711a142afe56f99acb573262a20541dc4b2f39c71d3364d4f933210695fbbafca5221e5f0bf1d166aaad8cadb18993a2303bd40a57c9e1bf01313936c4a8a24541f772c70c1975bea41683ba97b8fca5221e1784f8482b7f246de2a4288c7b99f31497b764c4a46947a0935cfea1a3de3be197b538543ee5f2978a78b82f8e56664bdac44951989343e1646f97b764c4e413214695ed5cfe125077b72af0cf5cde52118fbd427ce4852eefa46ce2a4288c9b0034d82daea7454c7e1a62244a2b76ae0475bfbc168bbae2f64968422cb4bc7e8ccfc52eefa46ce2a4284cdceef9072e5fe9888bd645a8c7493ee2f29682faff658847652b97bf54c4e39f427c5a693736715214e6fba1701f76f94a475ce2484959d84eb05d44fddd84975f603d97bf54c4e3ba5a7ce456976f5236711214c43d9ebcd1e52d1d71f9548893dce6f29682fa7f3ec4438a9d1edd84989c1762245bbabc93b08993a0107b8742c9e92e6fe9884bd3c097df71f9878e7adf01fab68ff1788bcb5f3262f2bc10239979cd049b38090ae126b71ceaf2968eb89c11e25439d0e51f3aeabd4b8843e50c97bf64c4e48f428c64e6ae769b38090a71562894e4146083b83c3cc4a972aacb3f74d4fbd1210e95c7bafc2523266eb0ddccfb49d8c4495088b8c28d0676aceff2968eb86c0ab7376091b326a977d3da0839143820265a5036eeb4fd7697771236711214e273a150c56e753d0ee2e35e7a7d0fc58d05a0ceefacc5a0923d000d884bfcac7dcee59b844d9c048588abdc5ee7f2a5db119fa625c18ada0d97fa6aa3542dfd15e370a3cb9ffe3366d784587ddbe59b844d9c048588835bdee5f2a5db119f478578555ee5f20f15f53d2ad4bf52ec4ec9ab213671ccc44f5cbe49d8c47151002d5d1c7fd35ee6f2a6db111fed0ee426c068f3d43ddd3143433db501e60f46f58e720f8906c4e6e2102bb599997e3adac47171f18d6a85a99ce7f2a6df20466f0f31ab14f1f84b3d9ba601eb5d48fefe6f406cdccfc78d5cde71d9c47171f1ad4261e4af5ddef41bc4485b62bb013032e83101d46f5bb8272079b23b26dd8ef8bc3cc44b669a336113c7c5c5770e85911cc43106e27476885be5752eff50503fb7d6bd5c8fdc416a05c4e7c5b57855767679c76513c7c5c5770f8591e7b9bc694dc4497328dc5bf099bb76ba8cfab9c93fb2bbcb9f7e83189d14623673dc6ce2b8b8f8434261e4389737ad8d58bd3fc44ef452753397bfefa897dbef4ebeeaf2a7351127b742f04c9ba8dac47171f1434261e4092e6f5a1bb17a49885de52097bfefa8d76ea19e95735dfeb426e2f4b8103739c4e51d974d1c1717777db9836cbcf340acf60bb1abbcdce5ef3beae566b4492bebdb0d1d717213828e7279c76513c7c5c59f110a23fbbabc696dc46a036845e018c38fbafc7d47bde2ca51a21e8141fee4691b71dab716b7ca335cde71d9c471e9e2a130927f002640bcdc87425adbfea90ba8cfef86fa5506f9c76e1e8855e7fe00b89f0007bbbcc9235ecf0af1ab9cedf2f715f53937d4af52dc9e88d322560785d8c9527f02b897804f74799347bcee0af73340bbbfdcd11dd337d443c39fff6554af3a7583e6e3ff9888d5136ab1ab2cf525a0eb067cbacb9b9a11b3a6bef1235dfebea11eaeff5a2e72f99347bcdcbe924bed067403818a5cdd6616c4ec91218695de4fada60eebe28bb53ad51531f9a92dc4ebb9217eb2d481406e28f04b5dded48c9869714c4d8489b1945e7f4828ff09a13e95dcfe6b42c4cc8d1b59ea50603719a8a879ed6d216ecf0f71ac7c04bd1c234fb937871bf92747b863523362e6365159ea6420371d3877059e0271bb33e216eb955e7e5828f76b433d2ada233127fe4c8898b99e94a54e07760b825ce1f2a6d5113b37ae42be853bbb63ba8af2fe1e9aa6fdeee38e492b236e9786382e774110a1007149b06b5cbeb43a62b71ebe528b65dd9fba63ba88b2ea8be103b5b2d7bdd51d935647ecde1162b9dc25c18442c445416f70f9d27888df91219e959fe13eee98aea19c2fa895bb4e8ba0ece48e49ab23767f5f8ba5746251d0b854f1575cbe341ee2a76f4f374d5814eb4eff14a07c7f88a647ff5cf07306c4efe610cf4e2c0b1e3706d1ef92418c605b16e2a765b3dc56e2f237ee982ea06cdba069b14fbdf8cbf5fea644ec349e228e18edc4c6206e6bb0fbb9bc697cc4f06921a675c7bb63968932ad8f8fd5ca58f753e4a3ff0c889fd6918c71edc4d6606e73d0c35dde3419e27875886b455b447566092dcaa29f2d6f1c95cd39d61d97c6470cdd7e129dd81cd46d0ffe6297374d8638de13b7d6e25aa79183ffc51db74894417bd65d382a93935b7db78038ba81629dd81e5c8b5bc68215b9d9e53c10cbeb426cebf47b7b695b8a716d0d61be6c541647ef83eeee8e4d93218e17d5e25ad9d2e59d844d9c1405f97e2858eeefd602e2784088aba32784df77c7cf13d7d46ffef802d879a83b3e4d8638c6f72bb7ba7c93b28993a23071551bcdfdcea19e33207e1a47af1180f5b836f931fec09d671eb896d63078cfe8daabd1f0e6addd79d2f88861ec15fa88cb37299b38290a737e289c6ce3f2a6d511bb5df18fb5588e43836cf43b711d77ceb670fe83f15db83234f914b673e74bab23767a1714637ab1cb3b299b38290a7372289ceceff2a666c44c7dbd4f47d31800893fb7223d8db5fe61e39c9b60a537fdabf91172f5df2910370dae8af17ca1cb3b299b38290aa36f8558c067b9bcc9235e07e2a65afc9c2ba15983ab7d10f507e458ccfc338c73e82dbfbaa0be0177ad8ade45dc16d21c6d8c3ad31cf6d2102fb76e642b7f4c6de2a428cc0ea17072a1cb9bd6449c346beebdb5b835792bee503b4eabc3340db9ad68251e359e8debd71c07c76c81d3f055b873d76994dff6d05382e6acc719a2d1bf415385efe6ae9dd6449c5c37eb7d5dde49d9c46950a03897fd5b2e5fba1df1b9172e80bacaea7173f4adb9d6305ad21e0e3d5abb63eaf492f095d8137789e7199d4b5d7afa43aecd27fe061a6ce4ce15e9bceb8773a9f7a26985a33a3da968cbebff5a3f3ead89f8c497c15a30b69597ec36711a1428ce559641ad6ddf0662a28554b508e86adfde157d181bc7d0f36f1a22fa7f4679c7f54fd0bb828ba1d1865f82be955dde265ae9a771455afeedee18b7a740fe017aff914f0535c4c32dbb77a5cb3b0d9b380d0ae5c6aee77b0010870da1c61d674eae44eb028cb5e433f9b43293f68e77cb8bcfc3bbb16a2f0f79344458ef22c6791aa8e80fa3fe28695af486eebc2521066e3bf5135cde69d8c4695028fd068c057d87cb5b0aeaaf47eab331ce637a456be5ff093670e75c09c7e87a7f0b77de367c0813afe6c331fab97309567b3710693c899e52f670e72d01757783ad5a7bb2b689d3a260f14db17ee3fdfac55509a8af06f068fdf6ff8d491bbc7e1a6cebce3b09cea1dfe0ea7b77d798c6a7f147ee5a93e01c0fc0fb46e79cd4c7f1641433d59cbaaa5b387e79dce2f24ecb264e8bc2b9f1ca334f58e83aeaa847703db2be0b1a901363b01af502b43e6496736a3f3efd3458ad0bcff93cfe0cad0f33e69c0fc51598e6278bc641fc39eee5ce3d24d4718f519deb2e7179a76513a745e18e0e8595335cdebea35e77c4a3f166e8b13dd67b35ff8a3760ee6b27700dfd16df07fa69a19e077d0b7f192a837e9fdf887742abce6a50d742fae9b98eba1ad59df959b818ad44ef0ad435aaf11313ff5cea03eaf542c47ab73ab5da264e8bc269459858e0eb5ddebea23e9afd78069ad6bb5f8d86d1ea8338f34cae21211e1a0ff10a8c3bffa14edd6267625031a53efa1919eb3af34fc43a9b380b0aa86f967a81d5bdb489cbdb27d441dd5a7f819586e936d1b795bac4f433618d3ef3b426e2a3a795fdf0264cfa13414f62afc3bdddb9fb843adc09712c46ebeb6ddac4595048373168a61d4c9789b26f8a57639ac7fc8f4223f1b26f7b0ac44d7f745f8c499f0af4d3464f69bdfd6940d9dd54f0f35dde59d8c45950c8c343a1a5d517178b42b91f84afd7ea310e0dcad11e6e3bb873a6c9114b8d523c0cee9178251a4bf10877ceaea3dc7a3f14ebd3fa527b367116147203c44921faf6eccdcf00caaa0930fa9d3eee683d0d83567fff03ddf9527b88b1a64a6bf8b08637bb7b11a92bf639ee5c5d457935702cfed4d467aaf5271a9b382b0aea7e061ce7f2760de5d41fb06b6ae56ea286a59d5a345573ae73f0d3da88b976517a04ae85bb3f912629f562911acae97ad35a7ffc179b382b0aab2ea75881ceef184419b5cc55d34abc15bdd4fc5fc8a5cf3b827bb13b34ae60b589559aafd2f997b094d1ad033997fd146de2ac28acdee4ba69a49d9d074ed9f43b53b3ee6299eb3e8c5e6ccf5522ee8d063e696ab2bb77158d81b8933bbe0b289b8673c711a4fa2ccde5e9c526b68102ab5fb65e0939cbe5ed02caa62ebe58de8aba634e453eea771cf7487fc8358066a52ec457ba63bb80b2bd2c9455ce7479db6013db40a1770c95905bb0aecbbf4c9469273435184d48d9cf1d97ba8b7bb62f9ac66ce8675c2b0b6ab48932e9e5b3ebf2dcd1e56f834d6c0b05bf2154440e7479978932c56d972b6a40839fcb3054dcbbdf47d388cdf7b96396893269819758ceb9be3bb3896da1f0c787cac89b5dde65a13c4d6befeb85d2c296da4ef3c13ddc0b4db3320f73c72c0be5b93c944fe6ba0fa44d6c0b85d7b8f9389c51ffbf99cbbf6894432f2b9b26a2bcc11d93fa877be966a98a86ad77e2bd0ee558ca67c526b6890aa87ba65e2939c5e55d34caa19964b16ca247ff7bb86352ff702fb782762876f7ba134f0194e394502eb9c2e56d934d6c1395d04294b1625a936ee9cb3d5186a6c5299eeff2a7fee29ebaa9b5b2f4d9aa944123fff4998865dbd3e56f934d6c1b1571a3b54e75791785ebef16ca53f91a8a5975a614dc538df06c5a1865e17b2bd6717d7531c7325debf2b6cd26b68dca687a67aca0567659da5300d7d668be5826c9854c078a7beb3e687299cbbf085c5bdffe6eb7a785743ddbc479a042d7870acae92eefbc71ddbbc0f5fbabcfdfae9b9ffa8f7bab4d4de38b36515b58ca6435ae7b7aad1c9585fd2cb189f340a5dc0b37ed6fbf91cb3f4f5cf3885a19ea5eeff2a7e1e01e6b9f0577ef9fe8f2cf13d7d45a92fa0cc4b22c6cac8c4d9c172aa6b5e762655fe0f2ce13d7743d13727f973f0d07f778ef70cf2b6f71f9e7896bbe2094416e7479e7c526ce0b95d3a20eb1c25acf6de2bdeba6c5b5f432488ffab11c1f76f9d3f070afdd92e9ea265cd80a425c6b63a8edc7722cb45bd226ce0b95d3c09b9b6b95adb4b2d5f138b8d621e1da95135dfe343cdc6bf7cd2b07bbfcf3c0b55cb7a43e1b0b5db3c026ce1315d4c298b1e21aafbd90a700aee3765a955cc2ab10dceba62ee00b5cfeb6711d7dfbbb390a47bafcf36413e7894a6ab7932fd42a5d7985cbdf26aea16bbbc7ae2fbafc69b8b8e79a991adb815ec8cd7db62ad7d0f2e7f1dafa4c2c7ca6ac4d9c372aba7fade2154dd1dccde56f0be7d7cebcf1baf23f5cfe345cdc736d90e2dac2835dfeb6707e3d7db89d980f70f9e7cd262e021576339f3e89b9fd15e4dce7d4ae5537f3be77a95fb8e78f096da0f22a97bf0d9c5b4fa06ec5a285f740546ce22250e9ade1166c789ecb3f2bceab17906eb105ad21dfd925a2d27c70cf3781fb26fe86cbdf06cefd9c702d51efc33d5dfe45b0898b42c54faa05a2a22ebaed5cfe5970ce07d6ae51778dcb9f868f7bff81d0162aadff14e59cda22ddcd483cd9e55f149bb828545e8f44ae4ff66a977f169cf3d9e11a955ead199fdac3bd3f2db485ca092eff2c38a7768e8ed7d15a144bdd3edf262e1201685ab1e508977f5a9cef9270feca2e2e7f1a3eeefdfd425ba85ce8f24f8bf33d2e9c5fd4e697bee2944d5c3402715e2d3015cd90dadce59f06e7725d8f5f737953396803df0c6d426e7279a7c1b9b4b7a476848ed7b8c8e55f349bb868046373b84911adfc25e63cba09ee29e3752e7f2a076de0f5a14d88d6836c65921ae7715f6eb7a2135b99dbc4652020c7d4025437f3cc28cea1edbbdcb95bdf6c31f50b6de0f1a14d54661e0fc039d4eedc17cf5c17fa9c844d5c16027365089468c8e44cfbbd737cd37250735b6f3df5036d6097d0262a33ad5bc9f17aebef9e6ab5047d67f628b489cb4260b45087b6748e41fb34eeec8e1907c7bead76aecacf903bfd148e36a09e288d0589ed63eac1391cab19a76eeabb96246bedbd561b6ce23211206df4e856ebb9d4e51f07c7ba71df1f77795379680b1a811adbc7d42f8839f6e2702ef905f672f997c9262e1b816aadcf9e6334e2d09d2bd7fd4fff89b6f0c6d0362a13bfa8e39867857354963ae0a7894dec0202f6d61040d1d0cd895ece90ffd0daf17527b9fca93cb485e786b65199688e08f9b52dbe1b5efcb72e7f17d8c42e2068eabad312dd31985a3ffd77dc310e79ffac766cdd435dfe541edac2c342dba8bcc4e577c87b4f7caf766ce5ebe8c44e588e4dec0a02b707f4db2906f5e3186bed7ef2b99e05d9c2e54fe5a12d6c19da46e54d2e7f44be3be263b5e32a6abb73dfdc631636b14b0860d3e3d958bfe1c9e7e61a7cd7e54de5529b086d443ee6f246e43b3f1c5799cbccd636d9c4ae21904dabf89ee6f2d791c74d397eafcb9bca459bb826b411f9a1cb5b479ea6094573dfd7af0d36b16b08a61eb19aa66e36f60cf06f4d8f767fe5f2a772a94d843652d9d4e517fecdcdef17b5d55e6c2f6713bb88806a90d06746018eecf44dd235d3d0e53fdae54fe5a24d3c39b491caee0df94f08f92a6aa3bdd95dca26761581d536cfae6740e3ad8f33f9dd0ac4b2f46998a95b68130f0a6da4f20493f738b831fe6a9b5bc5fc5d6613bb8c00ef04b799a26ec83121ef4b6aff5e77af7abe946813db8436527951c8a7496beec3af36b9533d6f1fd8c4ae23d01a2eec9657d234ce5f2f24c27f5f54fbb7ca2fb1f0e59753b7a94dc00de2f9f59474fe5b7b4aaa8dc53c6a8bf6a742d7d9c43e20e007c08d11d007fcb1a33c1faaa557e6b6e863ea37b58dd056e483a37f7b2cd4b6e2bfab0d2e6549ef36d8c4be20f0fa8bec1ec7f497fcd1f84e2dadf22177ae94d436425b11b521b525f774a0b6d7ead2758b6613fb841b70e2e846c49be39e0e64ea598569d8d436425ba9b8b6a436d7fbfd246d62df7023f424d0f4818fce72e748496d23b495266a6bbdfee6afd8c43ee286e89d807b31183dc31d9f92da46682b8eda586f7ff34736b1afb831ea1d705d8475b90d58b2681b0785b612a96df5f26d7f139bd867dc208d137083852a390d3859b48dfd425ba9539bea5d3fff6a6c62df71a33462b069d8b02607ad35ba2b958d3671187e346a2391da52af46f88dcb260e01374c73079a261089d66bcf4d410b471bd044b3d78cda84a336d49bb1fd93b28943c18dd3cd6d9a4a2c9fc3aeeed8347cdcfbfb402b4ebbb6216a3bbd98d5372d9b3834dc442d2ad2d44da8dd88d7984390868f7bfe2434f51aa9ad3cd71d3734367188b8a15a5e6ca597835aca7943776c1a0edd63b8392215b5913ddcb1436413878a1bab8546dd6ac3952fe161eed8d47fbab7a37beceebda86d342e0032443671e8b8c9da77c06d3e52d156e27773c7a6fed1bd1cdd5377af456de1d9eed8a1b38925e0866bd090db86aca21d5c9f8eceece39626a37b37ba87ba97ee1e8bdac0a006f74cc22696821bafaec2a665c32b37e0f7dcf1a9bb74cf46f7ceddd38aeefd60bbf8c661134b4323d02a2f2b0d21d654d057205f12769ceed1e85eb9e9bb15edda9b3d3fb08925a2416c8673e1567ca9686eb8de1f6ce0ce919647f764746fdc1a10154de1d500b04eedd0bb4c36b164340e7517baad9debbe0dad4330e841227da07b30ba17ba27ee5e55b4414ce776e75d369b583a1a8ad6877b266e836b4c956fe278acefce93e647311fc55ef7c0dd9b8ae67e9c845c07d2b089e976349a7b60a5eea38a3680d452d1ebb9f3a4f628c6a3582be6ee5ed45d8eaddd79d2ed6c625a138de821b879d4a856a245255f847bb8f3a4e929a6a3d8ba853ba32f607f779eb4269b98d646835a078fc767e11a5d9dde40ab8b697fe43882292976a3182a962bbdd5afe88fb43683c9c7fd31d9c4d48cc6a546f9287c02ae11465f863690dcd29d2fad4db11ac54cb173318df4d256f3f9f38fed846c621a0f0deee1704b493b1a6e7a19b4ec547623068ac928368ad14ac3b4ebaec781ee7c693c36314d8646f8605c3b6a94e3d014e4ab7034eeeace5902d51dda9453b1504c5cac1cc57a3f77ce34199b98a643a3dc135a44e2e7700dd7d16e33d7e164ece8ce3b24d4717b687d06adb4e376da69a2982ab67bbaf3a6e9d8c4341b1aa94615aa8f7ab5b1e8cee7a111891a9ebc2b7afbbb5665c7ced0b7fc6b71135c9d57a2182a969bb96ba4d9d8c4d41e1aee8e38135f856be0abd160a4f7e2a5d06fe42ddc75ba80b26d8e037106de839566e1ad44b152cc06ff44b46c3631b58fc6ac6fc37d703e561b61b81a4d617d37b498a57e3a68efbaddb089bb769bb8c6c6b83f0e851ee5cfc1bbb0d2421be3504c141bc528dfe62f884d4cf34503d71befc3470d7edcaeae71fd10eaa27c0bf453e2afa06f5375ab9d00bd78d4b51f017dd844ffad34fd9bf228af8ed1b1afc39bf171fc33dc35a7a5ba2b06ba76f68c2c814d4c8b45e3df06faf069adba7146baf595eaa63aaaaedbb858a4c5b28969b9f870e84df9d3a0dd6a579adeda752abbeaa0ba6cefea9a96cb26a66ee1c3b3030e867eefeb91f983586d0fc445525934204a653b052aeb0eae2ea95b6c62ea073e64ea6edc1bea32d4d6d66f83363bd1dc784d83d50218ee033b099d43e7ba05eac67b3b5e8e63a16be7e21a3d6613d330f0e154cfc346d05e89ea8fd742a89ad978088e82b6c316fdb7d2f46fcaa3bc5b43c7e61bf901b38929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a694ca6013534a65b08929a532d8c49452196c624aa90c3631a554069b98522a834d4c2995c126a6944af0abdffa0f50331f92e214a57e0000000049454e44ae426082);

-- --------------------------------------------------------

--
-- Table structure for table `tmajors`
--

CREATE TABLE `tmajors` (
  `ID` int(11) NOT NULL,
  `MajorCode` varchar(45) DEFAULT NULL,
  `MajorDescription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tmajors`
--

INSERT INTO `tmajors` (`ID`, `MajorCode`, `MajorDescription`) VALUES
(1, 'BAF', 'BANKING AND FINANCE'),
(2, 'COM ENG.', 'COMPUTER ENGINEERING'),
(3, 'COMSCI', 'COMPUTER SCIENCE'),
(4, 'EEd', 'ELEMENTARY EDUCATION'),
(5, 'INFO SYS', 'INFORMATION SYSTEM '),
(6, 'INFOTECH', 'INFORMATION TECHNOLOGY'),
(7, 'MKTNG', 'MARKETING'),
(8, 'SEC Ed', 'SECONDARY EDUCATION'),
(9, 'FM', 'FINANCIAL MANAGEMENT'),
(10, 'MA', 'MANAGEMENT ACCOUNTING'),
(11, 'BIOSCI', 'BIOLOGICAL SCIENCES'),
(12, 'ENG', 'ENGLISH'),
(13, 'FIL', 'FILIPINO'),
(14, 'MAP', 'MAPEH'),
(15, 'MATH', 'MATHEMATICS'),
(16, 'PHYSCI', 'PHYSICAL SCIENCES'),
(17, 'SCO SCI', 'SOCIAL SCIENCE'),
(18, 'TLE', 'TECHNOLOGY AND LIVELIHOOD EDUCATION'),
(19, 'AUTECH', 'AUTOMOTIVE TECHNOLOGY'),
(20, 'ET', 'ELECTRICAL TECHNOLOGY'),
(21, 'ELTECH', 'ELECTRONICS TECHNOLOGY'),
(22, 'MT', 'MECHANICAL TECHNOLOGY'),
(23, 'FOODTECH', 'FOOD TECHNOLOGY'),
(24, 'FACT', 'REFRIGERATION AND AIR CONDITIONING TECHNOLOGY'),
(25, 'GARM', 'GARMENTS'),
(26, 'DRAFTECH', 'DRAFTING TECHNOLOGY'),
(27, 'WEBPROG', 'WEB PROGRAMMING'),
(28, 'DRAFT', 'DRAFTING');

-- --------------------------------------------------------

--
-- Table structure for table `tnationalities`
--

CREATE TABLE `tnationalities` (
  `ID` int(11) NOT NULL,
  `NationalityCode` varchar(45) DEFAULT NULL,
  `NationalityDescription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tnationalities`
--

INSERT INTO `tnationalities` (`ID`, `NationalityCode`, `NationalityDescription`) VALUES
(1, 'AME ', 'AMERICAN'),
(2, 'IND', 'INDIAN'),
(3, 'FIL', 'FILIPINO'),
(4, 'JAP', 'JAPANESE'),
(5, 'KOR', 'KOREAN'),
(6, 'CHI', 'CHINESE'),
(7, 'INDO', 'INDONESIAN'),
(8, 'MAL', 'MALAYSIAN'),
(9, 'RUS', 'RUSSIAN'),
(10, 'VIET', 'VIETNAMESE'),
(11, 'NIG', 'NIGERIAN'),
(12, 'TAI', 'TAIWANESE'),
(13, 'PORT', 'PORTUGUESE'),
(14, 'AFR', 'AFRICAN'),
(15, 'GER', 'GERMAN'),
(16, 'ITA', 'ITALIAN'),
(17, 'IRA', 'IRANIAN'),
(18, 'ARAB', 'ARABIAN'),
(19, 'JAM', 'JAMAICAN'),
(20, 'NOR', 'NORWEDIAN');

-- --------------------------------------------------------

--
-- Table structure for table `tpositions`
--

CREATE TABLE `tpositions` (
  `ID` int(11) NOT NULL,
  `PositionCode` varchar(45) DEFAULT NULL,
  `PositionDescription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tpositions`
--

INSERT INTO `tpositions` (`ID`, `PositionCode`, `PositionDescription`) VALUES
(1, 'PROG', 'PROGRAMMER'),
(2, 'FAC', 'FACULTY'),
(3, 'CD', 'COLLEGE DEAN'),
(19, 'CEO', 'CAMPUS EXECUTIVE OFFICER'),
(20, 'JAN', 'JANITOR'),
(22, 'BS', 'BOARD SECRETARY'),
(23, 'LIB', 'LIBRARIAN'),
(24, 'LEC', 'LECTURER'),
(25, 'PRES.', 'PRESIDENT'),
(26, 'VP', 'VICE PRESIDENT'),
(27, 'SEC', 'SECRETARY'),
(28, 'ENG', 'ENGINEER'),
(29, 'DIR', 'DIRECTOR'),
(30, 'FIN', 'FINANCE'),
(31, 'GEN', 'GENERAL'),
(32, 'TRE', 'TREASURER'),
(33, 'CAPT', 'CAPTAIN'),
(34, 'ACCT', 'ACCOUNTANT'),
(35, 'DEV', 'DEVELOPER'),
(36, 'SG', 'SECURITY GUARD'),
(37, 'MAY', 'MAYOR'),
(38, 'VPAA', 'VICE PRESIDENT FOR ACADEMIC AFFAIRS'),
(39, 'INSP', 'INSPECTOR'),
(41, 'ADMIN', 'ADMINISTRATOR'),
(42, 'HT', 'HEAD TEACHER'),
(43, 'PPL', 'PRINCIPAL'),
(44, 'PRO', 'PROCTOR'),
(45, 'OIC', 'OFFICER IN CHARGE'),
(46, 'MNGR', 'MANAGER'),
(47, 'ORG', 'ORGANIZER'),
(48, 'ATTY', 'ATTORNEY'),
(52, 'DR.', 'DOCTOR');

-- --------------------------------------------------------

--
-- Table structure for table `treligions`
--

CREATE TABLE `treligions` (
  `ID` int(11) NOT NULL,
  `ReligionCode` varchar(45) DEFAULT NULL,
  `ReligionDescription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `treligions`
--

INSERT INTO `treligions` (`ID`, `ReligionCode`, `ReligionDescription`) VALUES
(1, 'ACC', 'APOSTOLIC CATHOLIC CHURCH'),
(2, 'AGL', 'AGLIPAYAN'),
(3, 'ANG', 'ANGLICAN'),
(4, 'BA', 'BORN AGAIN'),
(5, 'BAP', 'BAPTIST'),
(6, 'AOG', 'ASSEMBLY OF GOD'),
(7, 'CA', 'CHRISTIAN ALLIANCE'),
(8, 'CDCC', 'CDCC'),
(9, 'CGI', 'CHURCH OF GOD INTERNATIONAL'),
(10, 'CJCLDS', 'CJCLDS'),
(11, 'CLG', 'CHURCH OF THE LIVING GOD'),
(12, 'COC', 'CHURCH OF CHRIST'),
(13, 'CRS', 'CRUSADERS'),
(14, 'ESP', 'ESPIRITISTA'),
(15, 'FBCFI', 'FREE BELIEVERS IN CHRIST FELLOWSHIP INC'),
(16, 'IFI', 'IFI'),
(17, 'INC', 'IGLESIA NI CRISTO'),
(18, 'IND', 'INDEPENDIENTE'),
(19, 'JIA', 'JESUS IS ALIVE'),
(20, 'JIL', 'JESUS IS LORD'),
(21, 'JMC', 'JESUS MIRACLE CRUSADE'),
(22, 'JMCIM', 'JMCIM'),
(23, 'JW', 'JEHOVAHS WITNESSES'),
(24, 'LDS', 'LATTERY DAY SAINTS'),
(25, 'LUTH', 'LUTHERIAN'),
(26, 'METH', 'METHODIST'),
(27, 'MUS', 'MUSLIM'),
(28, 'PEN', 'PENTECOS'),
(29, 'PGS', 'PGS'),
(30, 'PRES', 'PRESBYTARIAN'),
(31, 'PRO', 'PROTESTANT'),
(32, 'RC', 'ROMAN CATHOLIC'),
(33, 'SDA', 'SEVENTH-DAY ADVENTIST'),
(34, 'UCCP', 'UCCP'),
(35, 'UECFI', 'UECFI'),
(36, 'UPC', 'UNITED PENTECOSTAL CHURCH'),
(37, 'WES', 'WESLEYAN');

-- --------------------------------------------------------

--
-- Table structure for table `trooms`
--

CREATE TABLE `trooms` (
  `ID` int(11) NOT NULL,
  `RoomCode` varchar(45) DEFAULT NULL,
  `RoomDescription` varchar(100) DEFAULT NULL,
  `RoomType` varchar(45) DEFAULT NULL,
  `BuildingID` int(11) DEFAULT NULL,
  `CollegeID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `trooms`
--

INSERT INTO `trooms` (`ID`, `RoomCode`, `RoomDescription`, `RoomType`, `BuildingID`, `CollegeID`) VALUES
(1, 'D1', 'D1', 'Lec', 4, 7),
(2, '101', '101', 'LECTURE', 1, 2),
(3, '102', '102', 'LECTURE', 3, 2),
(4, '10', NULL, NULL, NULL, NULL),
(5, '103', '103', 'LECTURE', 2, 4),
(6, '104', '104', 'LECTURE', 2, 4),
(7, '105', '105', 'LECTURE', NULL, NULL),
(8, '106', '106', 'LECTURE', NULL, NULL),
(9, '107', '107', 'LECTURE', NULL, NULL),
(10, '201', '201', 'LECTURE', NULL, NULL),
(11, '202', '202', 'LECTURE', NULL, NULL),
(12, '203', '203', 'LECTURE', NULL, NULL),
(13, '204', '204', 'LECTURE', NULL, NULL),
(14, '204/LAB', '204/LAB', 'LAB', NULL, NULL),
(15, '207', '207', 'LECTURE', NULL, NULL),
(16, '207/LAB', '207/LAB', 'LAB', NULL, NULL),
(17, '208', '208', 'LECTURE', NULL, NULL),
(18, '301', '301', 'LECTURE', NULL, NULL),
(19, '301/LAB', '301/LAB', 'LAB', NULL, NULL),
(20, '302', '302', 'LECTURE', NULL, NULL),
(21, '302/LAB', '302/LAB', 'LAB', NULL, NULL),
(22, '303', '303', 'LECTURE', NULL, NULL),
(23, '304', '304', 'LECTURE', NULL, NULL),
(24, '405', '405', 'LECTURE', NULL, NULL),
(25, '406', '406', 'LECTURE', NULL, NULL),
(26, '407', '407', 'LECTURE', NULL, NULL),
(27, 'A1', 'A1', 'LECTURE', NULL, NULL),
(28, 'A1LAB', 'A1LAB', 'LAB', NULL, NULL),
(29, 'A1', 'A1', 'LECTURE', NULL, NULL),
(30, 'A2', 'A2', 'LECTURE', NULL, NULL),
(31, 'A3', 'A3', 'LECTURE', NULL, NULL),
(32, 'A4', 'A4', 'LECTURE', NULL, NULL),
(33, 'A5', 'A5', 'LECTURE', NULL, NULL),
(34, 'A6', 'A6', 'LECTURE', NULL, NULL),
(35, 'A7', 'A7', 'LECTURE', NULL, NULL),
(36, 'A8', 'A8', 'LECTURE', NULL, NULL),
(37, 'AVR', 'AVR', 'LAB', NULL, NULL),
(38, 'B1', 'B1', 'LECTURE', NULL, NULL),
(39, 'B1LAB', 'B1LAB', 'LAB', NULL, NULL),
(40, 'B3', 'B3', 'LECTURE', NULL, NULL),
(41, 'B4', 'B4', 'LECTURE', NULL, NULL),
(42, 'B5', 'B5', 'LECTURE', NULL, NULL),
(43, 'B6', 'B6', 'LECTURE', NULL, NULL),
(44, 'B7', 'B7', 'LECTURE', NULL, NULL),
(45, 'B8', 'B8', 'LECTURE', NULL, NULL),
(46, 'B-3', 'B-3', 'LECTURE', NULL, NULL),
(47, 'BIOLAB', 'BIOLAB', 'LAB', NULL, NULL),
(48, 'C1', 'C1', 'LECTURE', NULL, NULL),
(49, 'C2', 'C2', 'LECTURE', NULL, NULL),
(50, 'C4', 'C4', 'LECTURE', NULL, NULL),
(51, 'C LAB', 'C LAB', 'LAB', NULL, NULL),
(52, 'C1', 'C1', 'LECTURE', NULL, NULL),
(53, 'C2', 'C2', 'LECTURE', NULL, NULL),
(54, 'C3', 'C3', 'LECTURE', NULL, NULL),
(57, 'C4', 'C4', 'LECTURE', NULL, NULL),
(58, 'C5', 'C5', 'LECTURE', NULL, NULL),
(59, 'C6', 'C6', 'LECTURE', NULL, NULL),
(60, 'C7', 'C7', 'LECTURE', NULL, NULL),
(61, 'C8', 'C8', 'LECTURE', NULL, NULL),
(62, 'CHEMLAB', 'CHEMLAB', 'LAB', NULL, NULL),
(63, 'CL-A', 'CL-A', 'LAB', NULL, NULL),
(64, 'CL-B', 'CL-B', 'LAB', NULL, NULL),
(65, 'CL-C', 'CL-C', 'LAB', NULL, NULL),
(66, 'CL-D', 'CL-D', 'LAB', NULL, NULL),
(67, 'CL-F', 'CL-F', 'LAB', NULL, NULL),
(68, 'CL-G', 'CL-G', 'LAB', NULL, NULL),
(69, 'CLINLAB', 'CLINLAB', 'LECTURE', NULL, NULL),
(70, 'D-1', 'D-1', 'LECTURE', NULL, NULL),
(71, 'D-2', 'D-2', 'LECTURE', NULL, NULL),
(72, 'D-3', 'D-3', 'LECTURE', NULL, NULL),
(73, 'D-3 LAB', 'D-3 LAB', 'LAB', NULL, NULL),
(74, 'D1', 'D1', 'LECTURE', NULL, NULL),
(75, 'D2', 'D2', 'LECTURE', NULL, NULL),
(76, 'D3', 'D3', 'LECTURE', NULL, NULL),
(77, 'D4', 'D4', 'LECTURE', NULL, NULL),
(78, 'H1', 'H1', 'LECTURE', NULL, NULL),
(79, 'H2', 'H2', 'LECTURE', NULL, NULL),
(80, 'H3', 'H3', 'LECTURE', NULL, NULL),
(81, 'IT 101', 'IT 101', 'LECTURE', NULL, NULL),
(82, 'IT 102', 'IT 102', 'LECTURE', NULL, NULL),
(83, 'IT 201', 'IT 201', 'LECTURE', NULL, NULL),
(84, 'IT 202', 'IT 202', 'LECTURE', NULL, NULL),
(85, 'IT 203', 'IT 203', 'LECTURE', NULL, NULL),
(86, 'LAW BLDG', 'LAW BLDG', 'LECTURE', NULL, NULL),
(87, 'MT 1', 'MT 1', 'LECTURE', NULL, NULL),
(88, 'MT 2', 'MT 2', 'LECTURE', NULL, NULL),
(89, 'MT 3', 'MT 3', 'LECTURE', NULL, NULL),
(90, 'PHYLAB', 'PHYLAB', 'LAB', NULL, NULL),
(91, 'SCILAB', 'SCILAB', 'LAB', NULL, NULL),
(92, 'SHOP', 'SHOP', 'LECTURE', NULL, NULL),
(93, 'SHOPLAB', 'SHOPLAB', 'LAB', NULL, NULL),
(94, 'T-1', 'T-1', 'LECTURE', NULL, NULL),
(95, 'T-2', 'T-2', NULL, NULL, NULL),
(96, 'T-3', 'T-3', 'LECTURE', NULL, NULL),
(97, 'T-4', 'T-4', 'LECTURE', NULL, NULL),
(98, 'T-5', 'T-5', 'LECTURE', NULL, NULL),
(99, 'T-6', 'T-6', 'LECTURE', NULL, NULL),
(100, 'T-7', 'T-7', 'LECTURE', NULL, NULL),
(101, 'T-8', 'T-8', 'LECTURE', NULL, NULL),
(102, 'VETCHEM', 'VETCHEM', 'LAB', NULL, NULL),
(103, 'Y1', 'Y1', 'LECTURE', NULL, NULL),
(104, 'Y2', 'Y2', 'LECTURE', NULL, NULL),
(105, 'asd', 'asd', 'Lecture', 9, 11),
(106, 'IT 101', 'Info Tech 101', 'Lecture', 13, 2),
(107, 'IT 101', 'IT 101', 'Lecture', 13, 3);

-- --------------------------------------------------------

--
-- Table structure for table `tsalarygrades`
--

CREATE TABLE `tsalarygrades` (
  `ID` int(11) NOT NULL,
  `GradeCode` varchar(45) DEFAULT NULL,
  `GradeDescription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tsalarygrades`
--

INSERT INTO `tsalarygrades` (`ID`, `GradeCode`, `GradeDescription`) VALUES
(1, 'SG1', 'Salary Grade 1'),
(2, 'SG2', 'Salary Grade 2'),
(3, 'SG3', 'Salary Grade 3'),
(5, 'SG4', 'Salary Grade 4');

-- --------------------------------------------------------

--
-- Table structure for table `tscholarships`
--

CREATE TABLE `tscholarships` (
  `ID` int(11) NOT NULL,
  `ScholarshipCode` varchar(45) DEFAULT NULL,
  `ScholarshipDescription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tscholarships`
--

INSERT INTO `tscholarships` (`ID`, `ScholarshipCode`, `ScholarshipDescription`) VALUES
(1, '01', 'ACADEMIC SCHOLARSHIP'),
(2, '08', 'JUORNALISM SCHOLARSHIP'),
(3, '11A', 'CHED SCHOLARSHIP(HEDP)'),
(4, '11C', 'CHED SCHOLARSHIP(NSP)'),
(5, '11I', 'CHED SCHOLARSHIP(SG-IEP)'),
(6, '02A', 'Entrance Scholarship (Undergraduate Students-Valedictorians and Salutatorians)'),
(7, '02B1', 'Entrance Scholarship (Graduate Students-Summa Cum Laude'),
(8, '02B2', 'Entrance Scholarship (Graduate Students-Magna Cum Laude)'),
(9, '02B3', 'Entrance Scholarship (Graduate Students-Cum Laude)'),
(10, '03', 'Institutional Medical Scholarship Program'),
(11, '04', 'Grant-in-Aid Scholarship Program'),
(12, '05A', 'CSU Kaagapay sa Kinabukasan Program(100%)'),
(13, '05B', 'CSU Kaagapay sa Kinabukasan Program(50%)'),
(14, '06A', 'Socio-Cultural Study Grant (Choir)'),
(15, '06B', 'Socio-Cultural Study Grant (Linna-aw Dance Troupe)'),
(16, '06C1', 'Socio-Cultural Study Grant (Athletic Study Grant-100%)'),
(17, '06C2', 'Socio-Cultural Study Grant (Athletic Study Grant-50%)'),
(18, '07', 'Faculty Personnel Study Grant'),
(19, '08', 'Journalism Scholarship'),
(20, '091', 'USG/CSG Study Grant (President)'),
(21, '092', 'USG/CSG Study Grant (Vice-President)'),
(22, '093', 'USG/CSG Study Grant (Senator)'),
(23, '094', 'USG/CSG Study Grant (Governor)'),
(24, '101', 'Cadet Military Training (CMT) Privileges (Corp Commander)'),
(25, '102', 'Cadet Military Training (CMT) Privileges (Deputy Corp Commander'),
(26, '103', 'Cadet Military Training (CMT) Privileges (Corps S-1-4)'),
(27, '11B', 'CHED SCHOLARSHIP (NSP)'),
(28, '11D', 'CHED SCHOLARSHIP (SNPL)'),
(29, '11E', 'CHED SCHOLARSHIP (PWD)'),
(30, '11F', 'CHED SCHOLARSHIP (SSP)'),
(31, '11G', 'CHED SCHOLARSHIP (SEGEAP)'),
(32, '11H', 'CHED SCHOLARSHIP (NISGP)'),
(33, '11J', 'CHED SCHOLARSHIP (DND-CHED-PASUC Scholarship Program)'),
(34, '12', 'DOST-SEI  Scholarship Program'),
(35, '13', 'Cagayan Provincial Government Assistance Program (CPGAP)'),
(36, '14', 'Pres. Diosdado Macapagal Agrarian Scholarship Program(PMASP)'),
(37, '15', 'Barangay Study Grant Program'),
(38, '16', 'Barangay Health Worker Scholarship Grant'),
(39, '17', 'SK Scholarship'),
(40, '18', 'Babaran Scholarship Foundation'),
(41, '19', 'JOLLIBEE  Aral- Kabuhayan Scholarship Program'),
(42, '20', 'JOLLIBEE  Aral- Kabuhayan Scholarship Program'),
(43, '999', 'NCIP Batanes');

-- --------------------------------------------------------

--
-- Table structure for table `tschools`
--

CREATE TABLE `tschools` (
  `ID` int(11) NOT NULL,
  `SchoolCode` varchar(45) DEFAULT NULL,
  `SchoolDescription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tschools`
--

INSERT INTO `tschools` (`ID`, `SchoolCode`, `SchoolDescription`) VALUES
(2, 'CSU', 'CAGAYAN STATE UNIVERSITY'),
(3, 'USLT', 'UNIVERSITY OF SAINT LOUIS TUGUEGARAO '),
(4, 'SPUP', 'ST. PAUL UNIVERSITY PHILIPPINES'),
(5, 'UCV', 'UNIVERSITY OF CAGAYAN VALLEY'),
(6, 'FL.VARGAS', 'FL. VARGAS COLLEGE'),
(7, 'MRC', 'MAILA ROSARIO COLLEGE'),
(8, 'AMA', 'AMA COMPUTER COLLEGE');

-- --------------------------------------------------------

--
-- Table structure for table `tschoolyears`
--

CREATE TABLE `tschoolyears` (
  `id` int(11) NOT NULL,
  `description` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tschoolyears`
--

INSERT INTO `tschoolyears` (`id`, `description`) VALUES
(1, '2013-2014');

-- --------------------------------------------------------

--
-- Table structure for table `tstudgrades`
--

CREATE TABLE `tstudgrades` (
  `ID` int(11) NOT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `SubjectID` int(11) DEFAULT NULL,
  `Grades` varchar(45) DEFAULT NULL,
  `Remarks` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tstudgrades`
--

INSERT INTO `tstudgrades` (`ID`, `StudentID`, `SubjectID`, `Grades`, `Remarks`) VALUES
(1, NULL, 268, '95', 'TEST');

-- --------------------------------------------------------

--
-- Table structure for table `tsubjects`
--

CREATE TABLE `tsubjects` (
  `ID` int(11) NOT NULL,
  `SubjectCode` varchar(45) DEFAULT NULL,
  `SubjectDescription` varchar(100) DEFAULT NULL,
  `Level` varchar(45) DEFAULT NULL,
  `Units` int(11) DEFAULT NULL,
  `Imported` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tsubjects`
--

INSERT INTO `tsubjects` (`ID`, `SubjectCode`, `SubjectDescription`, `Level`, `Units`, `Imported`) VALUES
(1, '6035', 'TAXATION 1', 'COLLEGE', 3, 'NO'),
(2, 'ACCTG 55', 'FUNDAMENTALS OF ACCOUNTING PART 1', 'COLLEGE', 3, 'NO'),
(3, 'ACCTG 55A', 'BASIC ACCOUNTING', 'COLLEGE', 3, 'NO'),
(4, 'ACCTG 56', 'FUNDAMENTALS OF ACCOUNTING PART 2', 'COLLEGE', 3, 'NO'),
(5, 'ACCTG 59A', 'COST ACCOUNTING', 'COLLEGE', 3, 'NO'),
(6, 'ACCTG 57', 'FINANCIAL ACCTG. THEORY & PRACTICE PART 1', 'COLLEGE', 3, 'NO'),
(7, 'ACCTG 58', 'FINANCIAL ACCTG THEORY & PRACTICE PART  II', 'COLLEGE', 3, 'NO'),
(8, 'ACCTG 59', 'COST ACCOUNTING & COST MANAGEMENT', 'COLLEGE', 3, 'NO'),
(9, 'ACCTG 60', 'CONSTRUCTIVE ACCOUNTING (FINANCIAL ACCOUNTING PART III)', 'COLLEGE', 3, 'NO'),
(10, 'ACCTG 61', 'AUDITING THEORY (ASSURANCE, PRINCIPLES, PROFESSIONAL ETHICS, GOOD GOVERNANCE)', 'COLLEGE', 3, 'NO'),
(11, 'ACCTG 61A', 'MANAGEMENT AUDIT/INTERNAL AUDIT', 'COLLEGE', 3, 'NO'),
(12, 'ACCTG 62', 'MANAGEMENT ACCOUNTING Part 1', 'COLLEGE', 3, 'NO'),
(13, 'ACCTG 62A', 'FUNDAMENTALS OF MANAGEMENT ACCOUNTING', 'COLLEGE', 3, 'NO'),
(14, 'ACCTG 63', 'AUDITING PRACTICE (PRACTICAL AUDITING)', 'COLLEGE', 3, 'NO'),
(15, 'ACCTG 64', 'ADVANCED ACCOUNTING 1', 'COLLEGE', 3, 'NO'),
(16, 'ACCT 65', 'MANAGEMENT ACCOUNTING PART II', 'COLLEGE', 3, 'NO'),
(17, 'ACCT 66', 'MANAGEMENT ACCOUNTING PART III', 'COLLEGE', 3, 'NO'),
(18, 'ACCTG 67', 'MANAGEMENT CONSULTANCY', 'COLLEGE', 3, 'NO'),
(19, 'ACCTG 67A', 'PARTNERSHIP & CORPORATE ACCOUNTING', 'COLLEGE', 3, 'NO'),
(20, 'ACCTG 68', 'ADVANCE ACCOUNTNG 2', 'COLLEGE', 3, 'NO'),
(21, 'ACCTG 68A', 'BUSINESS ACCOUNTING', 'COLLEGE', 3, 'NO'),
(22, 'ACCTG 69', 'ACCOUNTING FOR GOVERNMENT, NOT-FOR-PROFIT ENTITIES & SPECIAL ENTERPRISES', 'COLLEGE', 3, 'NO'),
(23, 'ACCTG 70', 'INTEGRATED COURSE in FINANCIAL ACCTG & REPORTING', 'COLLEGE', 3, 'NO'),
(24, 'ACCTG 70A', 'PUBLIC BUDGETING & ACCOUNTING', 'COLLEGE', 3, 'NO'),
(25, 'ACCTG 70B', 'MANAGEMENT ACCOUNTING', 'COLLEGE', 3, 'NO'),
(26, 'ACCTG 71', 'INTEGRATED COURSE IN ADVANCED ACCOUNTING', 'COLLEGE', 3, 'NO'),
(28, 'ACCTG 72', 'INTEGRATED COURSE IN MANAGEMENT ADVISORY SERVICES', 'COLLEGE', 3, 'NO'),
(29, 'ACCTG 73', 'INTEGRATED COURSE IN AUDITING', 'COLLEGE', 3, 'NO'),
(30, 'ACCTG 74', 'SYNTHESIS', 'COLLEGE', 3, 'NO'),
(31, 'ACCTG 95', 'ACCOUNTING/AUDIT PRACTICUM (200 HOURS)', 'COLLEGE', 4, 'NO'),
(32, 'ACCTG REV 1', 'INTEGRATED COURSE IN THEORY OF ACCOUNTS', 'COLLEGE', 3, 'NO'),
(33, 'ACCTG REV 2', 'INTEGRATED COURSE IN BUSINESS LAW', 'COLLEGE', 3, 'NO'),
(34, 'ACCTG REV 3', 'INTEGRATED COURSE IN TAXATION', 'COLLEGE', 3, 'NO'),
(35, 'ACCTG REV 4', 'INTEGRATED COURSE IN PRACTICAL ACCOUNTING PROBLEMS 1', 'COLLEGE', 3, 'NO'),
(36, 'ACCTG REV 5', 'INTEGRATED COURSE IN PRACTICAL ACCOUNTING PROBLEMS 2', 'COLLEGE', 3, 'NO'),
(37, 'ACCTG REV 6', 'INTEGRATED COURSE IN AUDITING THEORY', 'COLLEGE', 3, 'NO'),
(38, 'ACCTG REV 7', 'INTEGRATED COURSE IN MANAGEMENT SERVICES', 'COLLEGE', 3, 'NO'),
(39, 'ACCTG REV 8', 'INTEGRATED COURSE IN AUDITING PROBLEMS', 'COLLEGE', 3, 'NO'),
(40, 'ADMLAW', 'ADMINISTRATIVE LAW', 'COLLEGE', 3, 'NO'),
(41, 'AE 100', 'THESIS OPTION', 'COLLEGE', 3, 'NO'),
(42, 'AE 100A', 'COURSEWORK OPTION', 'COLLEGE', 3, 'NO'),
(43, 'AE 55', 'ENGINEERING SHOP', 'COLLEGE', 3, 'NO'),
(44, 'AE 56', 'AGRICULTURAL ENTREPRENEURSHIP, MANAGEMENT, AND EXTENSION', 'COLLEGE', 3, 'NO'),
(45, 'AE 57', 'INTRODUCTION TO OPERATIONS RESEARCH', 'COLLEGE', 3, 'NO'),
(46, 'AE 58', 'COMPUTER APPLICATIONS IN AGRICULTURAL ENGINEERING', 'COLLEGE', 3, 'NO'),
(47, 'AE 59', 'AE LAWS, CONTRACTS & ETHICS', 'COLLEGE', 3, 'NO'),
(48, 'AE 60', 'AQUACULTURE ENGINEERING', 'COLLEGE', 3, 'NO'),
(49, 'AE 61', 'HYDROLOGY', 'COLLEGE', 3, 'NO'),
(50, 'AE 62', 'IRRIGATION & DRAINAGE ENGINEERING', 'COLLEGE', 3, 'NO'),
(51, 'AE 63', 'SOIL & WATER CONSERVATION ENGINEERING', 'COLLEGE', 3, 'NO'),
(52, 'AE 65', 'KINETIC & DYNAMIC MACHINERY', 'COLLEGE', 3, 'NO'),
(53, 'AE 66', 'DESIGN OF AGRICULTURAL MACHINES', 'COLLEGE', 3, 'NO'),
(54, 'AE 67', 'FARM POWER', 'COLLEGE', 3, 'NO'),
(55, 'AE 68', 'AGRICULTURAL MACHINERY & EQUIPMENT', 'COLLEGE', 3, 'NO'),
(56, 'AE 70', 'FOREST PRODUCT ENGINEERING', 'COLLEGE', 3, 'NO'),
(57, 'AE 71', 'DESIGN OF AGRICULTURAL STRUCTURES', 'COLLEGE', 3, 'NO'),
(58, 'AE 72', 'ENVIRONMENTAL CONTROL ENGINEERING', 'COLLEGE', 3, 'NO'),
(59, 'AE 75', 'HEAT TRANSFER', 'COLLEGE', 3, 'NO'),
(60, 'AE 76', 'REFRIGERATION ENGINEERING', 'COLLEGE', 3, 'NO'),
(61, 'AE 77', 'FARM ELECTRIFICATION ENGINEERING', 'COLLEGE', 3, 'NO'),
(62, 'AE 78', 'AGRICULTURAL PROCESSING & HANDLING', 'COLLEGE', 3, 'NO'),
(63, 'AE 80', 'AGRICULTURAL ENGINEERING REVIEW', 'COLLEGE', 3, 'NO'),
(64, 'AE 95', 'ON-THE-JOB TRAINING', 'COLLEGE', 9, 'NO'),
(65, 'AGBUS 11', 'AGRIBUSINESS MANAGEMENT', 'COLLEGE', 3, 'NO'),
(66, 'AGECON 11', 'AGRICULTURAL ECONOMICS', 'COLLEGE', 3, 'NO'),
(67, 'AGENCY', 'AGENCY & PARTNERSHIP', 'COLLEGE', 3, 'NO'),
(68, 'AGRALAW', 'AGRARIAN LAW & SOCIAL LEGISTATION', 'COLLEGE', 3, 'NO'),
(69, 'AN SCI 11', 'INTRODUCTION TO ANIMAL SCIENCE', 'COLLEGE', 3, 'NO'),
(70, 'ANI SCI 11', 'PRINCIPLES OF ANIMAL PRODUCTION', 'COLLEGE', 3, 'NO'),
(71, 'AN SCI 55', 'POULTRY PRODUCTION & HEALTH MANAGEMENT', 'COLLEGE', 3, 'NO'),
(72, 'ANI SCI 56', 'SWINE PRODUCTION', 'COLLEGE', 3, 'NO'),
(73, 'ANI SCI 57', 'PRINCIPLES OF ANIMAL NUTRITION', 'COLLEGE', 3, 'NO'),
(74, 'ANI SCI 61', 'RUMINANT PRODUCTION', 'COLLEGE', 3, 'NO'),
(75, 'ANI SCI 64', 'EQUINE PRODUCTION', 'COLLEGE', 3, 'NO'),
(76, 'ANI SCI 65', 'PRINCIPLES OF ANIMAL BREEDING & GENETICS', 'COLLEGE', 3, 'NO'),
(77, 'ANSCI 95A', 'FIELD PRACTICE', 'COLLEGE', 3, 'NO'),
(78, 'AUTO TECH 55', 'AUTOMOTIVE TECHNOLOGY OPERATION I', 'COLLEGE', 3, 'NO'),
(79, 'AUTO TECH 56', 'AUTOMOTIVE TECHNOLOGY OPERATION II', 'COLLEGE', 3, 'NO'),
(80, 'AUTO TECH 57', 'AUTOMOTIVE ELECTRICITY & TROUBLESHOOTING', 'COLLEGE', 3, 'NO'),
(81, 'AUTO TECH 58', 'AUTOMOTIVE CHASSIS SERVICE, DRIVING & REPAIR', 'COLLEGE', 3, 'NO'),
(82, 'AUTO TECH 59', 'GAS, DIESEL TEST AND EVALUATION', 'COLLEGE', 3, 'NO'),
(83, 'AUTO TECH 60', 'ADVANCED AUTOMOTIVE TECHNOLOGY PARTS, ACCESORIES & EQUIPMENT', 'COLLEGE', 3, 'NO'),
(84, 'AUTO TECH 95', 'OJT (INDUSTRY TRAINING ATTACHMENT)', 'COLLEGE', 3, 'NO'),
(85, 'B LAW 57A', 'LAW ON SALES, AGENCY, LABOR & OTHER COMMERCIAL LAWS', 'COLLEGE', 3, 'NO'),
(86, 'B LAW 59', 'LAW ON BUSINESS ORGANIZATION', 'COLLEGE', 3, 'NO'),
(87, 'B LAW 59 A ', 'INTEGRATED COURSE IN BUSINESS LAW', 'COLLEGE', 3, 'NO'),
(88, 'B LAW 61', 'LAW ON OBLIGATIONS & CONTRACTS', 'COLLEGE', 3, 'NO'),
(89, 'B LAW 62', 'NEGOTIABLE INSTRUMENT LAW', 'COLLEGE', 3, 'NO'),
(90, 'BA 58', 'ENTREPRENEURIAL BEHAVIOR', 'COLLEGE', 3, 'NO'),
(91, 'BA 59', 'BUSINESS ORGANIZATION AND MANAGEMENT', 'COLLEGE', 3, 'NO'),
(92, 'BA 61', 'PRINCIPLES OF MARKETING', 'COLLEGE', 3, 'NO'),
(93, 'BA 63', 'BUSINESS POLICY & STRATEGY', 'COLLEGE', 3, 'NO'),
(94, 'BA 63A', 'BUSINESS POLICY', 'COLLEGE', 3, 'NO'),
(95, 'BA 65', 'MANAGING A SERVICE ENTERPRISE', 'COLLEGE', 3, 'NO'),
(96, 'BA 65A', 'MANAGING A SERVICE ENTERPRISE', 'COLLEGE', 3, 'NO'),
(97, 'BA 66', 'PRODUCTION & OPERATION MANAGEMENT', 'COLLEGE', 3, 'NO'),
(98, 'BA 70', 'BUSINESS OPPORTUNITIES I', 'COLLEGE', 3, 'NO'),
(99, 'BA 71', 'BUSINESS OPPORTUNITIES II', 'COLLEGE', 3, 'NO'),
(100, 'BA 72', 'BUSINESS PLAN I', 'COLLEGE', 3, 'NO'),
(101, 'BA 73', 'BUSINESS PLAN II', 'COLLEGE', 3, 'NO'),
(102, 'BA 74', 'BUSINESS PLAN IMPLEMENTATION I', 'COLLEGE', 3, 'NO'),
(103, 'BA 75', 'NEW MARKET DEVELOPMENT', 'COLLEGE', 3, 'NO'),
(104, 'BA 75A', 'BUSINESS PLAN IMPLEMENTATION II', 'COLLEGE', 3, 'NO'),
(105, 'BA 76', 'BUSINESS PLAN IMPLEMENTATION 2', 'COLLEGE', 3, 'NO'),
(106, 'BA 77', 'MANAGING A MANUFACTURING ENTERPRISE', 'COLLEGE', 3, 'NO'),
(107, 'BA 78', 'FRANCHISING', 'COLLEGE', 3, 'NO'),
(108, 'BA 80', 'BUSINESS STATISTICS', 'COLLEGE', 3, 'NO'),
(109, 'BA 81', 'OPERATION RESEARCH', 'COLLEGE', 3, 'NO'),
(110, 'BA 82', 'INCOME TAXATION', 'COLLEGE', 3, 'NO'),
(111, 'BA 95', 'ENTREPRENEURIAL INTEGRATION', 'COLLEGE', 3, 'NO'),
(112, 'BASLEG', 'BASIC LEGAL COMMUNICATION SKILLS', 'COLLEGE', 3, 'NO'),
(113, 'BIO 100', 'THESIS WRITNG', 'COLLEGE', 3, 'NO'),
(114, 'BIO 11', 'GENERAL BIOLOGY 1', 'COLLEGE', 3, 'NO'),
(115, 'BIO 11A', 'BIOLOGICAL SCIENCE', 'COLLEGE', 3, 'NO'),
(116, 'BIO 12', 'GENERAL BIOLOGY', 'COLLEGE', 3, 'NO'),
(117, 'BIO 13', 'GENERAL BIOLOGY I', 'COLLEGE', 3, 'NO'),
(118, 'BIO 14', 'GENERAL BIOLOGY 2', 'COLLEGE', 3, 'NO'),
(119, 'BIO 55', 'PLANT MORPHOANATOMY', 'COLLEGE', 3, 'NO'),
(120, 'BIO 56', 'PLANT TAXONOMY', 'COLLEGE', 3, 'NO'),
(121, 'BIO 57', 'MICROBIOLOGY', 'COLLEGE', 3, 'NO'),
(122, 'BIO 57A', 'INTRODUCTION TO MICROBIOLOGY', 'COLLEGE', 3, 'NO'),
(123, 'BIO 57B', 'HUMAN ANATOMY', 'COLLEGE', 3, 'NO'),
(124, 'BIO 58', 'COMPARATIVE VERTEBRATE ANATOMY', 'COLLEGE', 3, 'NO'),
(125, 'BIO 59', 'CELL AND MOLECULAR BIOLOGY', 'COLLEGE', 3, 'NO'),
(126, 'BIO 60', 'ELEMENTARY GENETICS', 'COLLEGE', 3, 'NO'),
(127, 'BIO 61', 'ANIMAL TAXONOMY', 'COLLEGE', 3, 'NO'),
(128, 'BIO 62', 'GENERAL ECOLOGY', 'COLLEGE', 3, 'NO'),
(129, 'BIO 62A', 'FUNDAMENTALS OF ECOLOGY', 'COLLEGE', 3, 'NO'),
(130, 'BIO 63', 'DEVELOPMENTAL BIOLOGY OF VERTEBRATE', 'COLLEGE', 3, 'NO'),
(131, 'BIO 64', 'PLANT PHYSIOLOGY', 'COLLEGE', 3, 'NO'),
(132, 'BIO 65', 'ANIMAL PHHYSIOLOGY', 'COLLEGE', 3, 'NO'),
(133, 'BIO 65A', 'HUMAN PHYSIOLOGY', 'COLLEGE', 3, 'NO'),
(134, 'BIO 66', 'GENERAL PARASITOLOGY', 'COLLEGE', 3, 'NO'),
(135, 'BIO 67', 'ENTOMOLOGY/IMMUNOLOGY/RADIATION BIOLOGY', 'COLLEGE', 3, 'NO'),
(136, 'BIO 68', 'BIOLOGICAL EVOLUTION', 'COLLEGE', 3, 'NO'),
(137, 'BIO 68A', 'HUMAN HISTOLOGY', 'COLLEGE', 3, 'NO'),
(138, 'BIO 69', 'HISTOLOGY', 'COLLEGE', 3, 'NO'),
(139, 'BIO 70', 'BIOMETRICS', 'COLLEGE', 3, 'NO'),
(140, 'BIO 90', 'UNDERGRADUATE SEMINAR', 'COLLEGE', 3, 'NO'),
(141, 'BIO 95', 'ON-THE-JOB TRAINING', 'COLLEGE', 9, 'NO'),
(142, 'BIO SCI 55', 'CELL BIOLOGY', 'COLLEGE', 3, 'NO'),
(143, 'BIO SCI 56', 'ANATOMY AND PHYSIOLOGY', 'COLLEGE', 3, 'NO'),
(144, 'BIO SCI 57', 'BIOTECHNIQUES', 'COLLEGE', 3, 'NO'),
(145, 'BL 57', 'LAW ON SALES, AGENCY & CREDIT TRANSACTIONS', 'COLLEGE', 3, 'NO'),
(146, 'BL 61', 'THE LAW ON OBLIGATIONS AND CONTRACTS', 'COLLEGE', 3, 'NO'),
(147, 'BL 62', 'LAW AND NEGOTIABLE INSTRUMENTS', 'COLLEGE', 3, 'NO'),
(148, 'BL 63', 'COMMERCIAL PAPERS & NEGOTIABLE INSTRUMENTS', 'COLLEGE', 3, 'NO'),
(149, 'BL 64', 'PARTNERSHIP & AGENCY', 'COLLEGE', 3, 'NO'),
(150, 'BL 65', 'THE CORPORATION CODE & RELATED LAWS', 'COLLEGE', 3, 'NO'),
(151, 'BN 11', 'BASIC NUTRITION', 'COLLEGE', 3, 'NO'),
(152, 'BOT 11', 'GENERAL BOTANY', 'COLLEGE', 3, 'NO'),
(153, 'BUS MATH 11', 'BUSINESS CALCULUS', 'COLLEGE', 3, 'NO'),
(154, 'BUS MATH 12', 'MATHEMATICS OF INVESTMENTS', 'COLLEGE', 3, 'NO'),
(155, 'BUS MATH 13', 'QUANTITATIVE TECHNIQUES IN BUSINESS', 'COLLEGE', 3, 'NO'),
(156, 'BUS STAT 11', 'BUSINESS STATISTICS', 'COLLEGE', 3, 'NO'),
(157, 'CE 55', 'SURVEYING I', 'COLLEGE', 3, 'NO'),
(158, 'CE 56', 'ENGINEERING GEOLOGY', 'COLLEGE', 3, 'NO'),
(159, 'CE 57', 'SURVEYING II', 'COLLEGE', 3, 'NO'),
(160, 'CE 58', 'THEORY OF STRUCTURES I', 'COLLEGE', 3, 'NO'),
(161, 'CE 59', 'HIGHWAY ENGINEERING', 'COLLEGE', 3, 'NO'),
(162, 'CE 60', 'THEORY OF STRUCTURES II', 'COLLEGE', 3, 'NO'),
(163, 'CE 61', 'SOIL MECHANICS', 'COLLEGE', 3, 'NO'),
(164, 'CE 62', 'HYDRAULICS', 'COLLEGE', 3, 'NO'),
(165, 'CE 63', 'CONSTRUCTION MATERIALS & TESTING', 'COLLEGE', 3, 'NO'),
(166, 'CE 64', 'STRUCTURAL DESIGN I', 'COLLEGE', 3, 'NO'),
(167, 'CE 65', 'MATRIX STRUCTURAL ANALYSIS', 'COLLEGE', 3, 'NO'),
(168, 'CE 66', 'EARTHQUAKE ENGINEERING', 'COLLEGE', 3, 'NO'),
(169, 'CE 67', 'ARCHITECTURAL DRAFTING & ESTIMATING', 'COLLEGE', 3, 'NO'),
(170, 'CE 68', 'HYDROLOGY', 'COLLEGE', 3, 'NO'),
(171, 'CE 69', 'FOUNDATION ENGINEERING', 'COLLEGE', 3, 'NO'),
(172, 'CE 70', 'STRUCTURAL DESIGN 2 (STEEL DESIGN)', 'COLLEGE', 3, 'NO'),
(173, 'CE 71', 'STRUCTURAL DESIGN 3 (TIMBER DESIGN)', 'COLLEGE', 3, 'NO'),
(174, 'CE 72', 'CE LAWS, CONTRACTS & ETHICS', 'COLLEGE', 3, 'NO'),
(175, 'CE 73', 'CONSTRUCTION PROJECT MANAGEMENT', 'COLLEGE', 3, 'NO'),
(176, 'CE 74', 'CE PROJECT STUDY', 'COLLEGE', 3, 'NO'),
(177, 'CE 95', 'ON-THE-JOB TRAINING', 'COLLEGE', 9, 'NO'),
(178, 'CHE 100', 'THESIS WRITING', 'COLLEGE', 3, 'NO'),
(179, 'CHE 12A', 'CHEMISTRY OF MATERIALS', 'COLLEGE', 3, 'NO'),
(180, 'CHE 55', 'CHE CALCULATIONS 1', 'COLLEGE', 3, 'NO'),
(181, 'CHE 56', 'CHE CALCULATIONS 2', 'COLLEGE', 3, 'NO'),
(182, 'CHE 57', 'PHYSICAL CHEMISTRY', 'COLLEGE', 3, 'NO'),
(183, 'CHE 58', 'PHYSICAL CHEMISTRY 2', 'COLLEGE', 3, 'NO'),
(184, 'CHE 59', 'CHE THERMODYNAMICS', 'COLLEGE', 3, 'NO'),
(185, 'CHE 60', 'PROCESS EQUIPMENT DESIGN', 'COLLEGE', 3, 'NO'),
(186, 'CHE 61', 'UNIT OPERATIONS 1', 'COLLEGE', 3, 'NO'),
(187, 'CHE 62', 'CHEMICAL PROCESS INDUSTRIES', 'COLLEGE', 3, 'NO'),
(188, 'CHE 63', 'CHE TTHERMODYNAMICS 2', 'COLLEGE', 3, 'NO'),
(189, 'CHE 64', 'UNIT OPERATIONS 2', 'COLLEGE', 3, 'NO'),
(190, 'CHE 65', 'ELECTIVE 1', 'COLLEGE', 3, 'NO'),
(191, 'CHE 66', 'REACTION KINETICS 1', 'COLLEGE', 3, 'NO'),
(192, 'CHE 67', 'ENVIRONMENTAL ENGINEERING', 'COLLEGE', 3, 'NO'),
(193, 'CHE 69', 'UNIT OPERATIONS 3', 'COLLEGE', 3, 'NO'),
(194, 'CHE 70', 'CHE LAB 1', 'COLLEGE', 3, 'NO'),
(195, 'CHE 71', 'REACTIONS KINETICS 2', 'COLLEGE', 3, 'NO'),
(196, 'CHE 72', 'PLANT DESIGN', 'COLLEGE', 3, 'NO'),
(197, 'CHE 73', 'PROCESS CONTROL & INSTRUMENTATION', 'COLLEGE', 3, 'NO'),
(198, 'CHE 74', 'CHE LAB 2', 'COLLEGE', 3, 'NO'),
(199, 'CHE 76', 'ELECTIVE II', 'COLLEGE', 3, 'NO'),
(200, 'CHE 77', 'CHE LAWS, CONTRACTS & ETHICS', 'COLLEGE', 3, 'NO'),
(201, 'CHE 78', 'ELECTIVE III', 'COLLEGE', 3, 'NO'),
(202, 'CHE 79', 'BIOCHEMICAL ENGINEERING', 'COLLEGE', 3, 'NO'),
(203, 'CHE 80', 'COMPUTER APPLICATION TO CHE', 'COLLEGE', 3, 'NO'),
(204, 'CHE 95', 'ON-THE-JOB TRAINING', 'COLLEGE', 9, 'NO'),
(205, 'CHEM 11', 'GENERAL CHEMISTRY', 'COLLEGE', 3, 'NO'),
(206, 'CHEM 11A', 'GENERAL CHEMISTRY 1', 'COLLEGE', 3, 'NO'),
(207, 'CHEM 12', 'GENERAL CHEMISTRY 2', 'COLLEGE', 3, 'NO'),
(208, 'CHEM 13', 'INORGANIC CHEMISTRY', 'COLLEGE', 3, 'NO'),
(209, 'CHEM 13A', 'GENERAL AND INORGANIC CHEMISTRY I', 'COLLEGE', 3, 'NO'),
(210, 'CHEM 14', 'ORGANIC CHEMISTRY I', 'COLLEGE', 3, 'NO'),
(211, 'CHEM 14A', 'ORGANIC CHEMISTRY', 'COLLEGE', 3, 'NO'),
(212, 'CHEM 15', 'ORGANIC CHEMISTRY 2', 'COLLEGE', 3, 'NO'),
(213, 'CHEM 17', 'ANALYTICAL CHEMISTRY', 'COLLEGE', 3, 'NO'),
(214, 'CHEM 20', 'QUALITATIVE CHEMICAL ANALYSIS', 'COLLEGE', 3, 'NO'),
(215, 'CHEM 21', 'QUANTITATIVE CHEMICAL ANALYSIS', 'COLLEGE', 3, 'NO'),
(216, 'CHEM 22', 'BIOCHEMISTRY', 'COLLEGE', 3, 'NO'),
(217, 'CHEM 66', 'ENVIRONMENTAL CHEMISTRY & TOXICOLOGY PESTICIDE RESIDUE ANALYSIS', 'COLLEGE', 3, 'NO'),
(218, 'CIVLAREV I', 'CIVIL LAW REVIEW 1', 'COLLEGE', 3, 'NO'),
(219, 'CIVLAREV II', 'CIVIL LAW REVIEW 2', 'COLLEGE', 3, 'NO'),
(220, 'CIVPRO', 'CIVIL PROCEDURE', 'COLLEGE', 3, 'NO'),
(221, 'COGNATE 1', 'COGNATE I', 'COLLEGE', 3, 'NO'),
(222, 'COGNATE A', 'COGNATE II', 'COLLEGE', 3, 'NO'),
(223, 'COGNATE B', 'COGNATE III', 'COLLEGE', 3, 'NO'),
(224, 'COM LEV', 'COMMERCIAL LAW REVIEW', 'COLLEGE', 3, 'NO'),
(225, 'COMP 11', 'INTRODUCTION TO COMPUTER SCIENCE 1', 'COLLEGE', 3, 'NO'),
(226, 'COMP 11A', 'INTRODUCTION TO COMPUTER SCIENCE 1 (USING TURBO C)', 'COLLEGE', 3, 'NO'),
(227, 'COMP 12', 'INTRODUCTION TO COMPUTER SCIENCE 2', 'COLLEGE', 3, 'NO'),
(228, 'COMP 13', 'COMPUTER PROGRAMMING', 'COLLEGE', 3, 'NO'),
(229, 'COMP 14', 'COMPUTER APPLICATION FOR ELECTRICAL ENGINEERING', 'COLLEGE', 3, 'NO'),
(230, 'CONFLICT', 'CONFLICT OF LAWS', 'COLLEGE', 3, 'NO'),
(231, 'CONSLAW1', 'CONSTITUTIONAL LAW 1', 'COLLEGE', 3, 'NO'),
(232, 'CONSLAW2', 'CONSTITUTIONAL LAW 2', 'COLLEGE', 3, 'NO'),
(233, 'CONSTREV', 'CONSTITUTIONAL REVIEW 2', 'COLLEGE', 3, 'NO'),
(234, 'COPYRIGHT', 'COPYRIGHT & INTELLECTUAL PROPERTY LAW', 'COLLEGE', 3, 'NO'),
(235, 'CORPLAW', 'CORPORATION LAW', 'COLLEGE', 3, 'NO'),
(236, 'CPE55', 'DATA STRUCTURE & ALGORITHM ANALYSIS', 'COLLEGE', 3, 'NO'),
(237, 'CPE 56', 'DATABASE MANAGEMENT SYSTEM', 'COLLEGE', 3, 'NO'),
(238, 'CPE 57', 'LOGIC CIRCUIT & SWITCHING THEORY', 'COLLEGE', 3, 'NO'),
(239, 'CPE 58', 'COMPUTER HARDWARE FUNDAMENTALS', 'COLLEGE', 3, 'NO'),
(240, 'CPE 59', 'STRUCTURE OF PROGRAMMING LANGUAGES', 'COLLEGE', 3, 'NO'),
(241, 'CPE 60', 'ADVANCED LOGIC CIRCUIT DESIGN', 'COLLEGE', 3, 'NO'),
(242, 'CPE 61', 'COMPUTER APPLICATION IN COMPUTER ENIGNEERING', 'COLLEGE', 3, 'NO'),
(243, 'CPE 62', 'COMPUTER SYSTEM ARCHITECHTURE', 'COLLEGE', 3, 'NO'),
(244, 'CPE 63', 'COMPUTER SYSTEM ORGANIZATION WITH ASSEMBLY LANGUAGE', 'COLLEGE', 3, 'NO'),
(245, 'CPE 64', 'OPERATING SYSTEM', 'COLLEGE', 3, 'NO'),
(246, 'CPE 65', 'MICROPROCESSOR SYSTEM', 'COLLEGE', 3, 'NO'),
(247, 'CPE 66', 'SOFTWARE ENGINEERING', 'COLLEGE', 3, 'NO'),
(248, 'CPE 67', 'DESIGN PROJECT 1', 'COLLEGE', 3, 'NO'),
(249, 'CPE 68', 'PROJECT MANAGEMENT', 'COLLEGE', 3, 'NO'),
(250, 'CPE 69', 'ENGINEERING ETHICS & COMPUTER LAWS', 'COLLEGE', 3, 'NO'),
(252, 'CPE 70', 'DIGITAL SIGNAL PROCESSING', 'COLLEGE', 3, 'NO'),
(253, 'CPE 71', 'Test & Quality Assurance', 'COLLEGE', 3, 'NO'),
(254, 'CPE 72', 'Design Project 2', 'COLLEGE', 3, 'NO'),
(255, 'CPE 73', 'Computer Networks', 'COLLEGE', 3, 'NO'),
(256, 'CPE 74', 'I/O & Memory System', 'COLLEGE', 3, 'NO'),
(257, 'CPE 75', 'Technopreneurship', 'COLLEGE', 3, 'NO'),
(258, 'CPE 95', 'On-the-Job Training', 'COLLEGE', 4, 'NO'),
(259, 'CREDTRAN', 'Credit Transaction', 'COLLEGE', 3, 'NO'),
(260, 'CRIMLAW 1', 'Criminal Law 1', 'COLLEGE', 3, 'NO'),
(261, 'CRIMLAW 2', 'Criminal Law 2', 'COLLEGE', 3, 'NO'),
(262, 'CRIMPRO', 'Criminal Procedure', 'COLLEGE', 3, 'NO'),
(263, 'CRIMREV', 'Criminal Law Review', 'COLLEGE', 3, 'NO'),
(264, 'CROP PROT 13', 'Principles of Crop Protection', 'COLLEGE', 3, 'NO'),
(265, 'CROP SC 11', 'Fundamentals Of Crop Production', 'COLLEGE', 3, 'NO'),
(266, 'CS101', 'CS Fundamentals', 'COLLEGE', 3, 'NO'),
(267, 'CS102', 'Computer Programming 1', 'COLLEGE', 3, 'NO'),
(268, 'Comp11', 'INTRODUCTION IN COMPUTER SCIENCE 1', 'COLLEGE', 3, 'NO'),
(269, 'COMP12', 'INTRODUCTION IN COMPUTER SCIENCE 2', 'COLLEGE', 3, 'NO'),
(270, 'Math 13', 'College Algebra', 'COLLEGE', 3, 'NO'),
(271, 'Eng 11', 'Grammar and Composition 1', 'COLLEGE', 3, 'NO'),
(272, 'Philo 11', 'Logic', 'COLLEGE', 3, 'NO'),
(273, 'Fil 11', 'Komunikasyon sa Akademikong Pilipino', 'COLLEGE', 3, 'NO'),
(274, 'PE 11', 'Physical Fitness', 'COLLEGE', 2, 'NO'),
(275, 'NSTP 11', 'National Service Training Program 1', 'COLLEGE', 3, 'NO'),
(276, 'IT 101', 'Database Management System 1', 'COLLEGE', 3, 'NO'),
(277, 'IT 102', 'Programming 1', 'COLLEGE', 3, 'NO'),
(278, 'Math 14', 'Plane Trigonometry', 'College', 3, 'NO'),
(279, 'Eng 12', 'Grammar and Composition 2', 'COLLEGE', 3, 'NO'),
(280, 'Eng 14', 'Speech Communication', 'COLLEGE', 3, 'NO'),
(281, 'Fil 12', 'Pagbasa at Pagsulat Tungo sa Pananaliksik', 'COLLEGE', 3, 'NO'),
(282, 'PE 12', 'Rhythmic Activities', 'COLLEGE', 2, 'NO'),
(283, 'NSTP 12', 'NSTP 2', 'COLLEGE', 2, 'NO'),
(284, 'IT 201', 'Accounting Principles', 'COLLEGE', 3, 'NO'),
(285, 'IT 202', 'Discrete Structures', 'COLLEGE', 3, 'NO'),
(286, 'IT 203', 'Network Management', 'COLLEGE', 3, 'NO'),
(287, 'IT 204', 'Operating Systems Application Concepts', 'COLLEGE', 3, 'NO'),
(288, 'IT 205', 'Programming 2', 'COLLEGE', 3, 'NO'),
(290, 'Lit 11', 'Literatures of the Philippines', 'COLLEGE', 3, 'NO'),
(291, 'Phy 13', 'General Physics  1', 'COLLEGE', 4, 'NO'),
(292, 'PE 13', 'Individual & Dual Sports Games', 'COLLEGE', 2, 'NO'),
(293, 'IT 101', 'ACCOUNTING PRINCIPLE', 'COLLEGE', 3, 'NO'),
(294, 'IT 102', 'DISCRETE STRACTURES', 'COLLEGE', 3, 'NO'),
(295, 'IT 203', 'NETWORK MANAGEMENT', 'COLLEGE', 3, 'NO'),
(296, 'IT 204', 'OPERATING SYSTEM APPLICATION CONCEPTS', 'COLLEGE', 3, 'NO'),
(297, 'IT 205', 'PROGRAMMING 2', 'COLLEGE', 3, 'NO'),
(298, 'ENG 18', 'BUSINESS COMMUNICATION', 'COLLEGE', 3, 'NO'),
(299, 'LIT 11', 'LITERATURES OF THE PHILIPPINES', 'COLLEGE', 3, 'NO'),
(300, 'PHY 13', 'GENERAL PHYSICS 1', 'COLLEGE', 3, 'NO'),
(301, 'PE 13 ', 'INDIVIDUAL AND DUAL SPORTS GAMES', 'COLLEGE', 2, 'NO'),
(302, 'IT 206', 'MULTIMEDIA SYSTEMES', 'COLLEGE', 3, 'NO'),
(303, 'IT 207', 'OBJECT-ORIENTED PROGRAMMING', 'COLLEGE', 3, 'NO'),
(304, 'IT 208', 'WEB DEVELOPMENT', 'COLLEGE', 3, 'NO'),
(305, 'LIT 12', 'LITERATURE OF THE WORLD', 'COLLEGE', 3, 'NO'),
(306, 'PHY 15', 'GENERAL PHYSICS 2', 'COLLEGE', 3, 'NO'),
(307, 'SOCSCI 11', 'PHILIPPINES HISTORY', 'COLLEGE', 3, 'NO'),
(308, 'STAT 12', 'PROBABILITY AND STATISTICS ', 'COLLEGE', 3, 'NO'),
(309, 'PE 14', 'DANCE AND RECREATIONAL ACTIVITIES', 'COLLEGE', 3, 'NO'),
(310, 'IT 301', 'DATABASE MANAGEMENT SYSTEM 2 ', 'COLLEGE', 3, 'NO'),
(311, 'IT 302', 'IT ELECTIVE 1', 'COLLEGE', 3, 'NO'),
(312, 'IT 303', 'SOFTWARE ENGINEERING ', 'COLLEGE', 3, 'NO'),
(313, 'RES 11', 'METHODS OF RESEARCH ', 'COLLEGE', 3, 'NO'),
(314, 'SOCSCI 12', 'POLITICS AND GOVERNANCE WITH PHILIPPINE CONSTITUTION ', 'COLLEGE', 3, 'NO'),
(315, 'SOCSCI 13', 'SOCIETY AND CULTURE WITH POPED AND HIV', 'COLLEGE', 3, 'NO'),
(316, 'PSYCHO 11', 'GENERAL PSYCHOLOGY WITH DAP', 'COLLEGE', 3, 'NO'),
(317, 'IT 304', 'COMPUTER ORGANIZATION ', 'COLLEGE', 3, 'NO'),
(318, 'IT 305', 'FREE ELECTIVE 1*', 'COLLEGE', 3, 'NO'),
(319, 'IT 306', 'FREE ELECTIVE 2*', 'COLLEGE', 3, 'NO'),
(320, 'IT 307', 'IT ELECTIVE 2**', 'COLLEGE', 3, 'NO'),
(321, 'IT 308', 'SYSTEM ANALYSIS AND DESIGN ', 'COLLEGE', 3, 'NO'),
(322, 'ECON 11', 'INTRODUCTION TO ECONOMICS WITH TAR', 'COLLEGE', 3, 'NO'),
(323, 'SOCSCI 14', 'RIZAL\'S LIFE, WORK  AND WRITINGS ', 'COLLEGE', 3, 'NO'),
(324, 'IT 401', 'CAPSTONE PROJECT', 'COLLEGE', 3, 'NO'),
(325, 'IT 402', 'FREE ELECTIVE 3*', 'COLLEGE', 3, 'NO'),
(326, 'IT 403', 'IT ELECTIVE 3*', 'COLLEGE', 3, 'NO'),
(327, 'IT 404', 'IT ELECTIVE 4* ', 'COLLEGE', 3, 'NO'),
(328, 'IT 405', 'IT PROFESSIONAL ETHICS', 'COLLEGE', 3, 'NO'),
(329, 'IT 406', 'INTERNSHIP/OJT/PRACTICUM ', 'COLLEGE', 9, 'NO'),
(330, 'Eng 18', 'Business Communication', 'COLLEGE', 3, 'NO'),
(331, 'SAM', 'SAMPLE', 'College', 0, 'NO');

-- --------------------------------------------------------

--
-- Table structure for table `tsubjectterm`
--

CREATE TABLE `tsubjectterm` (
  `ID` int(11) NOT NULL,
  `TermDescription` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tsubjectterm`
--

INSERT INTO `tsubjectterm` (`ID`, `TermDescription`) VALUES
(1, 'First Semester'),
(2, 'Second Semester'),
(3, 'First Trimester'),
(4, 'Second Trimester'),
(5, 'Third Trimester'),
(6, 'Summer');

-- --------------------------------------------------------

--
-- Table structure for table `tsubjectyears`
--

CREATE TABLE `tsubjectyears` (
  `ID` int(11) NOT NULL,
  `SubjectYearDescription` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tsubjectyears`
--

INSERT INTO `tsubjectyears` (`ID`, `SubjectYearDescription`) VALUES
(1, 'First Year'),
(2, 'Second Year'),
(3, 'Third Year'),
(4, 'Fourth Year'),
(5, 'Fifth Year'),
(6, 'Sixth Year'),
(7, 'Sevent Year'),
(8, 'Eight Year'),
(9, 'Ninth Year'),
(10, 'Tenth Year');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `school_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `curriculum_id` int(11) DEFAULT NULL,
  `l_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `f_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `m_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `school_id`, `curriculum_id`, `l_name`, `f_name`, `m_name`, `email`, `password`, `course_id`, `role_id`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'ZXCZXCZX', 0, 'Test', 'Test', 'Test', 'test', '$2y$10$KGIG5upJ.GlYqY.O/IOaKOJcz54uanpqb5kSeiUjjLxH77QpjmnZW', 1, 1, 'SrpWMtYdboPt6sih2gkPnbDmWHfrR79BP8xupVDUYvIy45HR4iGANOMvJVsC', NULL, '2017-11-20 02:33:13'),
(2, '', 1, 'admin', 'admin', 'admin', 'admin', 'secret', 0, 1, 'kiNBQL3hjyKZEOOna6p31Kzy5tGuJFLt4hsOxeVcJDhVsFlcgPc4FE5fdol5', NULL, NULL),
(28, 'TEST', 1, 'Test', 'Test', 'Test', 'student', 'secret', 1, 3, 'EynobIIYvObvhAMxj1yfD11Sut0d2Bk8H7PlabdtWYhqIcE5bwSDTv8sxLjO', NULL, NULL),
(29, 'TEST', 1, 'sephel', 'Test', 'Test', 'teacher', 'secret', 1, 2, 'LIH6SNdYvJasXPQ2r9MBljVle19ooJVlnhBBLE8nxyhFhtth8Tbk38AeJjS2', NULL, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vchecklists`
-- (See below for the actual view)
--
CREATE TABLE `vchecklists` (
`ID` int(11)
,`CurriculumID` int(11)
,`CurriculumCode` varchar(45)
,`SubjectID` int(11)
,`SubjectCode` varchar(45)
,`SubjectDescription` varchar(100)
,`Units` int(11)
,`LabUnits` varchar(45)
,`LecUnits` varchar(45)
,`LabHours` varchar(45)
,`LecHours` varchar(45)
,`SubjectYearDescription` varchar(45)
,`TermDescription` varchar(50)
,`PreRequisiteID` varchar(341)
,`PreRequisiteCODE` varchar(341)
,`SubjectType` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vcolleges`
-- (See below for the actual view)
--
CREATE TABLE `vcolleges` (
`ID` int(11)
,`CollegeCode` varchar(45)
,`CollegeDescription` varchar(100)
,`HeadID` varchar(45)
,`CollegeHead` varchar(183)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vcourses`
-- (See below for the actual view)
--
CREATE TABLE `vcourses` (
`ID` int(11)
,`CourseCode` varchar(45)
,`CourseTitle` varchar(100)
,`CollegeID` int(11)
,`CollegeCode` varchar(45)
,`CollegeDescription` varchar(100)
,`MajorID` int(11)
,`MajorCode` varchar(45)
,`MajorDescription` varchar(100)
,`NoOfYears` int(11)
,`EducationLevel` varchar(45)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vcurriculums`
-- (See below for the actual view)
--
CREATE TABLE `vcurriculums` (
`ID` int(11)
,`CurriculumCode` varchar(45)
,`EntryYear` int(11)
,`CourseID` int(11)
,`CourseCode` varchar(45)
,`CourseTitle` varchar(100)
,`CollegeID` int(11)
,`CollegeCode` varchar(45)
,`CollegeDescription` varchar(100)
,`MajorID` int(11)
,`MajorCode` varchar(45)
,`MajorDescription` varchar(100)
,`NoOfYears` int(11)
,`EducationLevel` varchar(45)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vdepartments`
-- (See below for the actual view)
--
CREATE TABLE `vdepartments` (
`ID` int(11)
,`DepartmentCode` varchar(45)
,`DepartmentDescription` varchar(100)
,`HeadID` varchar(45)
,`DepartmentHead` varchar(183)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vemployees`
-- (See below for the actual view)
--
CREATE TABLE `vemployees` (
`ID` int(11)
,`EmployeeID` varchar(45)
,`Salutation` varchar(45)
,`LastName` varchar(45)
,`FirstName` varchar(45)
,`MiddleName` varchar(45)
,`PositionID` int(11)
,`PositionCode` varchar(45)
,`PositionDescription` varchar(100)
,`DepartmentID` int(11)
,`DepartmentCode` varchar(45)
,`DepartmentDescription` varchar(100)
,`Gender` varchar(10)
,`ProfilePicture` mediumblob
,`Status` varchar(45)
,`RankID` int(11)
,`RankCode` varchar(45)
,`RankDescription` varchar(100)
,`GradeID` int(11)
,`GradeCode` varchar(45)
,`GradeDescription` varchar(100)
,`CollegeID` int(11)
,`CollegeCode` varchar(45)
,`CollegeDescription` varchar(100)
,`Address` varchar(200)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vemployeesalutation`
-- (See below for the actual view)
--
CREATE TABLE `vemployeesalutation` (
`DepartmentCode` varchar(45)
,`DepartmentDescription` varchar(100)
,`UndergraduateMaster` bigint(21)
,`Doctor` bigint(21)
,`Judge` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vemployeesgender`
-- (See below for the actual view)
--
CREATE TABLE `vemployeesgender` (
`DepartmentCode` varchar(45)
,`DepartmentDescription` varchar(100)
,`MALE` bigint(21)
,`FEMALE` bigint(21)
,`TOTAL` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vrooms`
-- (See below for the actual view)
--
CREATE TABLE `vrooms` (
`ID` int(11)
,`RoomCode` varchar(45)
,`RoomDescription` varchar(100)
,`RoomType` varchar(45)
,`BuildingID` int(11)
,`BuildingCode` varchar(45)
,`BuildingDescription` varchar(100)
,`CollegeID` int(11)
,`CollegeCode` varchar(45)
,`CollegeDescription` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vstudgrades`
-- (See below for the actual view)
--
CREATE TABLE `vstudgrades` (
);

-- --------------------------------------------------------

--
-- Structure for view `vchecklists`
--
DROP TABLE IF EXISTS `vchecklists`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`192.168.1.177` SQL SECURITY DEFINER VIEW `vchecklists`  AS  select `tchecklists`.`ID` AS `ID`,`vcurriculums`.`ID` AS `CurriculumID`,`vcurriculums`.`CurriculumCode` AS `CurriculumCode`,`tsubjects`.`ID` AS `SubjectID`,`tsubjects`.`SubjectCode` AS `SubjectCode`,`tsubjects`.`SubjectDescription` AS `SubjectDescription`,`tsubjects`.`Units` AS `Units`,`tchecklists`.`LabUnits` AS `LabUnits`,`tchecklists`.`LecUnits` AS `LecUnits`,`tchecklists`.`LabHours` AS `LabHours`,`tchecklists`.`LecHours` AS `LecHours`,`tsubjectyears`.`SubjectYearDescription` AS `SubjectYearDescription`,`tsubjectterm`.`TermDescription` AS `TermDescription`,(select group_concat(`tchecklistprerequisite`.`SubjectID` separator ', ') from `tchecklistprerequisite` where (`tchecklistprerequisite`.`ChecklistID` = `tchecklists`.`ID`) group by `tchecklistprerequisite`.`ChecklistID`) AS `PreRequisiteID`,(select group_concat(`a`.`SubjectCode` separator ', ') from (`tchecklistprerequisite` join `tsubjects` `a` on((`a`.`ID` = `tchecklistprerequisite`.`SubjectID`))) where (`tchecklistprerequisite`.`ChecklistID` = `tchecklists`.`ID`)) AS `PreRequisiteCODE`,`tchecklists`.`SubjectType` AS `SubjectType` from (((((`tchecklists` join `vcurriculums` on((`tchecklists`.`CurriculumID` = `vcurriculums`.`ID`))) join `tsubjects` on((`tchecklists`.`SubjectID` = `tsubjects`.`ID`))) join `tsubjectyears` on((`tchecklists`.`SubjectYearID` = `tsubjectyears`.`ID`))) left join `tsubjectterm` on((`tchecklists`.`SubjectTermID` = `tsubjectterm`.`ID`))) left join `tsubjects` `tsubjects1` on((`tchecklists`.`ID` = `tsubjects1`.`ID`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vcolleges`
--
DROP TABLE IF EXISTS `vcolleges`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`192.168.1.177` SQL SECURITY DEFINER VIEW `vcolleges`  AS  select `tcolleges`.`ID` AS `ID`,`tcolleges`.`CollegeCode` AS `CollegeCode`,`tcolleges`.`CollegeDescription` AS `CollegeDescription`,`temployees`.`EmployeeID` AS `HeadID`,concat(`temployees`.`Salutation`,' ',`temployees`.`FirstName`,' ',`temployees`.`MiddleName`,' ',`temployees`.`LastName`) AS `CollegeHead` from (`tcolleges` left join `temployees` on((`temployees`.`ID` = `tcolleges`.`CollegeHead`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vcourses`
--
DROP TABLE IF EXISTS `vcourses`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`192.168.1.177` SQL SECURITY DEFINER VIEW `vcourses`  AS  select `tcourses`.`ID` AS `ID`,`tcourses`.`CourseCode` AS `CourseCode`,`tcourses`.`CourseTitle` AS `CourseTitle`,`tcolleges`.`ID` AS `CollegeID`,`tcolleges`.`CollegeCode` AS `CollegeCode`,`tcolleges`.`CollegeDescription` AS `CollegeDescription`,`tmajors`.`ID` AS `MajorID`,`tmajors`.`MajorCode` AS `MajorCode`,`tmajors`.`MajorDescription` AS `MajorDescription`,`tcourses`.`NoOfYears` AS `NoOfYears`,`tcourses`.`EducationLevel` AS `EducationLevel` from ((`tcourses` join `tcolleges` on((`tcourses`.`CollegeID` = `tcolleges`.`ID`))) join `tmajors` on((`tmajors`.`ID` = `tcourses`.`MajorID`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vcurriculums`
--
DROP TABLE IF EXISTS `vcurriculums`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`192.168.1.177` SQL SECURITY DEFINER VIEW `vcurriculums`  AS  select `tcurriculums`.`ID` AS `ID`,`tcurriculums`.`CurriculumCode` AS `CurriculumCode`,`tcurriculums`.`EntryYear` AS `EntryYear`,`vcourses`.`ID` AS `CourseID`,`vcourses`.`CourseCode` AS `CourseCode`,`vcourses`.`CourseTitle` AS `CourseTitle`,`vcourses`.`CollegeID` AS `CollegeID`,`vcourses`.`CollegeCode` AS `CollegeCode`,`vcourses`.`CollegeDescription` AS `CollegeDescription`,`vcourses`.`MajorID` AS `MajorID`,`vcourses`.`MajorCode` AS `MajorCode`,`vcourses`.`MajorDescription` AS `MajorDescription`,`vcourses`.`NoOfYears` AS `NoOfYears`,`vcourses`.`EducationLevel` AS `EducationLevel` from (`tcurriculums` join `vcourses` on((`vcourses`.`ID` = `tcurriculums`.`CourseID`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vdepartments`
--
DROP TABLE IF EXISTS `vdepartments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`192.168.1.177` SQL SECURITY DEFINER VIEW `vdepartments`  AS  select `tdepartments`.`ID` AS `ID`,`tdepartments`.`DepartmentCode` AS `DepartmentCode`,`tdepartments`.`DepartmentDescription` AS `DepartmentDescription`,`temployees`.`EmployeeID` AS `HeadID`,concat(`temployees`.`Salutation`,' ',`temployees`.`FirstName`,' ',`temployees`.`MiddleName`,' ',`temployees`.`LastName`) AS `DepartmentHead` from (`tdepartments` left join `temployees` on((`temployees`.`ID` = `tdepartments`.`DepartmentHead`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vemployees`
--
DROP TABLE IF EXISTS `vemployees`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`192.168.1.177` SQL SECURITY DEFINER VIEW `vemployees`  AS  select `temployees`.`ID` AS `ID`,`temployees`.`EmployeeID` AS `EmployeeID`,`temployees`.`Salutation` AS `Salutation`,`temployees`.`LastName` AS `LastName`,`temployees`.`FirstName` AS `FirstName`,`temployees`.`MiddleName` AS `MiddleName`,`tpositions`.`ID` AS `PositionID`,`tpositions`.`PositionCode` AS `PositionCode`,`tpositions`.`PositionDescription` AS `PositionDescription`,`tdepartments`.`ID` AS `DepartmentID`,`tdepartments`.`DepartmentCode` AS `DepartmentCode`,`tdepartments`.`DepartmentDescription` AS `DepartmentDescription`,`temployees`.`Gender` AS `Gender`,`timages`.`ProfilePicture` AS `ProfilePicture`,`temployees`.`Status` AS `Status`,`tfacultyranks`.`ID` AS `RankID`,`tfacultyranks`.`RankCode` AS `RankCode`,`tfacultyranks`.`RankDescription` AS `RankDescription`,`tsalarygrades`.`ID` AS `GradeID`,`tsalarygrades`.`GradeCode` AS `GradeCode`,`tsalarygrades`.`GradeDescription` AS `GradeDescription`,`tcolleges`.`ID` AS `CollegeID`,`tcolleges`.`CollegeCode` AS `CollegeCode`,`tcolleges`.`CollegeDescription` AS `CollegeDescription`,`temployees`.`Address` AS `Address` from ((((((`temployees` join `tpositions` on((`tpositions`.`ID` = `temployees`.`PositionID`))) left join `tdepartments` on((`temployees`.`DepartmentID` = `tdepartments`.`ID`))) left join `timages` on((`temployees`.`EmployeeID` = `timages`.`EmployeeID`))) left join `tfacultyranks` on((`temployees`.`FacultyRankID` = `tfacultyranks`.`ID`))) left join `tsalarygrades` on((`temployees`.`SalaryGradeID` = `tsalarygrades`.`ID`))) left join `tcolleges` on((`temployees`.`CollegeID` = `tcolleges`.`ID`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vemployeesalutation`
--
DROP TABLE IF EXISTS `vemployeesalutation`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`192.168.1.177` SQL SECURITY DEFINER VIEW `vemployeesalutation`  AS  select `tdepartments`.`DepartmentCode` AS `DepartmentCode`,`tdepartments`.`DepartmentDescription` AS `DepartmentDescription`,(select count(0) from `temployees` where ((`temployees`.`DepartmentID` = `tdepartments`.`ID`) and (`temployees`.`Salutation` = 'Mr.'))) AS `UndergraduateMaster`,(select count(0) from `temployees` where ((`temployees`.`DepartmentID` = `tdepartments`.`ID`) and (`temployees`.`Salutation` = 'Dr.'))) AS `Doctor`,(select count(0) from `temployees` where ((`temployees`.`DepartmentID` = `tdepartments`.`ID`) and (`temployees`.`Salutation` = 'Judge'))) AS `Judge` from (`tdepartments` left join `temployees` on((`tdepartments`.`ID` = `temployees`.`DepartmentID`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vemployeesgender`
--
DROP TABLE IF EXISTS `vemployeesgender`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`192.168.1.177` SQL SECURITY DEFINER VIEW `vemployeesgender`  AS  select `tdepartments`.`DepartmentCode` AS `DepartmentCode`,`tdepartments`.`DepartmentDescription` AS `DepartmentDescription`,(select count(0) from `temployees` where ((`temployees`.`DepartmentID` = `tdepartments`.`ID`) and (`temployees`.`Gender` = 'MALE'))) AS `MALE`,(select count(0) from `temployees` where ((`temployees`.`DepartmentID` = `tdepartments`.`ID`) and (`temployees`.`Gender` = 'FEMALE'))) AS `FEMALE`,(select count(0) from `temployees` where (`temployees`.`DepartmentID` = `tdepartments`.`ID`)) AS `TOTAL` from (`tdepartments` left join `temployees` on((`tdepartments`.`ID` = `temployees`.`DepartmentID`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vrooms`
--
DROP TABLE IF EXISTS `vrooms`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`192.168.1.177` SQL SECURITY DEFINER VIEW `vrooms`  AS  select `trooms`.`ID` AS `ID`,`trooms`.`RoomCode` AS `RoomCode`,`trooms`.`RoomDescription` AS `RoomDescription`,`trooms`.`RoomType` AS `RoomType`,`tbuildings`.`ID` AS `BuildingID`,`tbuildings`.`BuildingCode` AS `BuildingCode`,`tbuildings`.`BuildingDescription` AS `BuildingDescription`,`tcolleges`.`ID` AS `CollegeID`,`tcolleges`.`CollegeCode` AS `CollegeCode`,`tcolleges`.`CollegeDescription` AS `CollegeDescription` from ((`tbuildings` join `trooms` on((`tbuildings`.`ID` = `trooms`.`BuildingID`))) join `tcolleges` on((`tcolleges`.`ID` = `trooms`.`CollegeID`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vstudgrades`
--
DROP TABLE IF EXISTS `vstudgrades`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`192.168.1.177` SQL SECURITY DEFINER VIEW `vstudgrades`  AS  select `tchecklists`.`ID` AS `ID`,`vcurriculums`.`ID` AS `CurriculumID`,`vcurriculums`.`CurriculumCode` AS `CurriculumCode`,`vcurriculums`.`CourseTitle` AS `CourseTitle`,`tsubjects`.`SubjectCode` AS `SubjectCode`,`tsubjects`.`SubjectDescription` AS `SubjectDescription`,`tsubjects`.`Units` AS `Units`,`tchecklists`.`LabUnits` AS `LabUnits`,`tchecklists`.`LecUnits` AS `LecUnits`,`tchecklists`.`LabHours` AS `LabHours`,`tchecklists`.`LecHours` AS `LecHours`,`tchecklists`.`SubjectTermID` AS `SubjectTermID`,`tsubjectterm`.`TermDescription` AS `TermDescription`,`tchecklists`.`SubjectYearID` AS `SubjectYearID`,`tsubjectyears`.`SubjectYearDescription` AS `SubjectYearDescription`,`tchecklists`.`SubjectType` AS `SubjectType`,`tchecklists`.`PreCoRequisiteID` AS `PreCoRequisiteID`,`tsubjects`.`SubjectCode` AS `PreCoRequisiteCode`,`tstudgrades`.`Grades` AS `grades` from (((((`tchecklists` join `tsubjects` on((`tchecklists`.`SubjectID` = `tsubjects`.`ID`))) join `tsubjectterm` on((`tchecklists`.`SubjectTermID` = `tsubjectterm`.`ID`))) join `vcurriculums` on((`vcurriculums`.`ID` = `tchecklists`.`CurriculumID`))) join `tsubjectyears` on((`tsubjectyears`.`ID` = `tchecklists`.`SubjectYearID`))) left join `tstudgrades` on((`tchecklists`.`SubjectID` = `tstudgrades`.`SubjectID`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `samle`
--
ALTER TABLE `samle`
  ADD PRIMARY KEY (`idsamle`);

--
-- Indexes for table `tbuildings`
--
ALTER TABLE `tbuildings`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tchecklistprerequisite`
--
ALTER TABLE `tchecklistprerequisite`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tchecklists`
--
ALTER TABLE `tchecklists`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tcities`
--
ALTER TABLE `tcities`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tcolleges`
--
ALTER TABLE `tcolleges`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tcontacts`
--
ALTER TABLE `tcontacts`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tcourses`
--
ALTER TABLE `tcourses`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tcurriculums`
--
ALTER TABLE `tcurriculums`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tdepartments`
--
ALTER TABLE `tdepartments`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `temployees`
--
ALTER TABLE `temployees`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tfacultyranks`
--
ALTER TABLE `tfacultyranks`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tfees`
--
ALTER TABLE `tfees`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `timages`
--
ALTER TABLE `timages`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tmajors`
--
ALTER TABLE `tmajors`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tnationalities`
--
ALTER TABLE `tnationalities`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tpositions`
--
ALTER TABLE `tpositions`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `treligions`
--
ALTER TABLE `treligions`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `trooms`
--
ALTER TABLE `trooms`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tsalarygrades`
--
ALTER TABLE `tsalarygrades`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tscholarships`
--
ALTER TABLE `tscholarships`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tschools`
--
ALTER TABLE `tschools`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tschoolyears`
--
ALTER TABLE `tschoolyears`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tstudgrades`
--
ALTER TABLE `tstudgrades`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tsubjects`
--
ALTER TABLE `tsubjects`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tsubjectterm`
--
ALTER TABLE `tsubjectterm`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tsubjectyears`
--
ALTER TABLE `tsubjectyears`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `samle`
--
ALTER TABLE `samle`
  MODIFY `idsamle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbuildings`
--
ALTER TABLE `tbuildings`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `tchecklistprerequisite`
--
ALTER TABLE `tchecklistprerequisite`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tchecklists`
--
ALTER TABLE `tchecklists`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- AUTO_INCREMENT for table `tcities`
--
ALTER TABLE `tcities`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tcolleges`
--
ALTER TABLE `tcolleges`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tcontacts`
--
ALTER TABLE `tcontacts`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tcourses`
--
ALTER TABLE `tcourses`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT for table `tcurriculums`
--
ALTER TABLE `tcurriculums`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tdepartments`
--
ALTER TABLE `tdepartments`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `temployees`
--
ALTER TABLE `temployees`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `tfacultyranks`
--
ALTER TABLE `tfacultyranks`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tfees`
--
ALTER TABLE `tfees`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `timages`
--
ALTER TABLE `timages`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `tmajors`
--
ALTER TABLE `tmajors`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `tnationalities`
--
ALTER TABLE `tnationalities`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `tpositions`
--
ALTER TABLE `tpositions`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `treligions`
--
ALTER TABLE `treligions`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `trooms`
--
ALTER TABLE `trooms`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `tsalarygrades`
--
ALTER TABLE `tsalarygrades`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tscholarships`
--
ALTER TABLE `tscholarships`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `tschools`
--
ALTER TABLE `tschools`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tschoolyears`
--
ALTER TABLE `tschoolyears`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tstudgrades`
--
ALTER TABLE `tstudgrades`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tsubjects`
--
ALTER TABLE `tsubjects`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=332;

--
-- AUTO_INCREMENT for table `tsubjectterm`
--
ALTER TABLE `tsubjectterm`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tsubjectyears`
--
ALTER TABLE `tsubjectyears`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
