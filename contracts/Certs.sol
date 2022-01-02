// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import { CertLib } from "./CertLib.sol";


contract Certs {

    mapping(address => CertLib.Issuer) issuers; // address => issuer
    mapping(address => mapping(string => CertLib.Student)) students; // (schoolId, studentId) => student
    mapping(address => mapping(string => CertLib.Subject)) subjects; // (schoolId, subjectId) => subject
    mapping(address => mapping(uint => CertLib.Cert)) certs; // (schoolId, certificateId) => certificate

    event CertAdded(
        address schoolId,
        uint certId
    );

    event CertsAdded(
        address schoolId,
        uint[] certIds
    );

    function addStudents(CertLib.Student[] memory _students) public {
        address schoolId = msg.sender;
        for (uint i = 0; i < _students.length; i++) {
            CertLib.Student memory student = _students[i];
            string memory studentId = student.id;
            students[schoolId][studentId] = student;
        }
    }

    function addStudent(CertLib.Student memory _student) public {
        address schoolId = msg.sender;
        string memory studentId = _student.id;
        students[schoolId][studentId] = _student;
    }

    function getStudent(address schoolId, string memory studentId) public view returns (CertLib.Student memory) {
        return students[schoolId][studentId];
    }

    function addSubjects(CertLib.Subject[] memory _subjects) public {
        address schoolId = msg.sender;
        for (uint i = 0; i < _subjects.length; i++) {
            CertLib.Subject memory subject = _subjects[i];
            string memory subjectId = subject.id;
            subjects[schoolId][subjectId] = subject;
        }
    }

    function addSubject(CertLib.Subject memory _subject) public {
        address schoolId = msg.sender;
        string memory subjectId = _subject.id;
        subjects[schoolId][subjectId] = _subject;
    }

    function getSubject(address schoolId, string memory subjectId) public view returns (CertLib.Subject memory) {
        return subjects[schoolId][subjectId];
    }

    function addCerts(CertLib.Cert[] memory _certs) public {
        uint[] memory certIds = new uint[](_certs.length);
        for (uint i = 0; i < _certs.length; i++) {
            CertLib.Cert memory cert = _certs[i];
            uint certId = cert.id;
            certs[msg.sender][certId] = cert;
            certIds[i] = certId;
        }
        emit CertsAdded(msg.sender, certIds);
    }

    function addCert(CertLib.Cert memory _cert) public {
        address schoolId = msg.sender;
        uint certId = _cert.id;
        certs[schoolId][certId] = _cert;
        emit CertAdded(schoolId, certId);
    }

    function getCert(address schoolId, uint certId) public view returns (CertLib.Cert memory) {
        return certs[schoolId][certId];
    }

    function verifyCert(CertLib.Cert memory _cert) public view returns (bool, CertLib.Issuer[] memory) {
        address schoolId = _cert.schoolId;
        uint certId = _cert.id;
        CertLib.Cert memory cert = certs[schoolId][certId];
        bool valid = CertLib.verifyCert(cert, _cert);
        CertLib.Issuer[] memory foundIssuers;
        if (valid) {
            for (uint i = 0; i < cert.issuers.length; i++) {
                CertLib.Issuer memory issuer = issuers[cert.issuers[i]];
                foundIssuers[i] = issuer;
            }
        }
        return (valid, foundIssuers);
    }
}
