package com.mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import static common.JDBCTemplate.*;

import com.mvc.dto.MVCDto;

public class MVCDao {
	
	
	
	public List<MVCDto> selectAll(){
		Connection con = getConnection();
		Statement stmt = null;
		ResultSet rs = null;
		List<MVCDto> res = new ArrayList<MVCDto>();
		
		String sql = " SELECT * FROM MVCBOARD ORDER BY SEQ DESC ";
		
		try {
			stmt = con.createStatement();
			System.out.println("3. query 준비 : " + sql);
			
			rs = stmt.executeQuery(sql);
			System.out.println("4.query 실행 및 리턴");
			
			while(rs.next()) {
				MVCDto dto = new MVCDto();
				dto.setSeq(rs.getInt(1));
				dto.setWriter(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setRegdate(rs.getDate(5));
				
				res.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("3.4단계 에러");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
			close(con);	
			System.out.println("5.db종료");
		}
		return res;
	}
	
	
	public MVCDto selectOne(int seq) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		MVCDto dto = new MVCDto();
		
		String sql = " SELECT * FROM MVCBOARD WHERE SEQ = ? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, seq);
			System.out.println("3.query 준비 : " + sql);
			
			rs = pstm.executeQuery();
			System.out.println("4.query 시행 및 리턴");
			while(rs.next()) {
				dto.setSeq(rs.getInt(1));
				dto.setWriter(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setRegdate(rs.getDate(5));
				
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		return dto;
	}
	
	
	public int insert(MVCDto dto) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		
		int res = 0;
		
		String sql = " INSERT INTO MVCBOARD VALUES(MVCBOARDSEQ.NEXTVAL,?,?,?,SYSDATE) ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, dto.getWriter());
			pstm.setString(2, dto.getTitle());
			pstm.setString(3, dto.getContent());
			
			res = pstm.executeUpdate();
			
			if(res > 0) {
				commit(con);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
		}
		
		return res;
	}

	
	public int update(MVCDto dto) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " UPDATE MVCBOARD SET TITLE = ?, CONTENT=? WHERE SEQ = ? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, dto.getTitle());
			pstm.setString(2, dto.getContent());
			pstm.setInt(3, dto.getSeq());
			System.out.println("3.query 준비 : " + sql);
			
			res = pstm.executeUpdate();
			System.out.println("4.query 실행 및 리턴");
			
			if(res > 0) {
				commit(con);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("5.db종료");
		}

		return res;
	}
	
	
	public int multiDelete(String[] seq) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		
		int res = 0;
		int[] cnt = null;
		
		String sql = " DELETE FROM MVCBOARD WHERE SEQ = ? ";
		
		try {
			pstm = con.prepareStatement(sql);
			
			for(int i = 0; i < seq.length; i++) {
				pstm.setString(1, seq[i]);
				pstm.addBatch();
				System.out.println("3.query 준비 : " + sql + "[seq=" + seq[i] + "]");
			}
			
			cnt = pstm.executeBatch();
			System.out.println("4.query 실행 및 리턴");
			
			for(int i = 0; i < cnt.length; i++) {
				if(cnt[i] == -2) {
					res++;
				}
			}
			
			if(seq.length == res) {
				commit(con);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4단계 에러");
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("5.db종료\n");
		}
		
		
		return res;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
