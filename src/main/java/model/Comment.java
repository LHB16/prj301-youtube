package model;

import java.util.Date;

public class Comment {
    private int commentId;
    private String content;
    private Date commentDate;
    private User user;
    private Video video;
    private int status;

    public Comment() {
    }

    public Comment(int commentId, String content, Date commentDate, User user, Video video, int status) {
        this.commentId = commentId;
        this.content = content;
        this.commentDate = commentDate;
        this.user = user;
        this.video = video;
        this.status = status;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(Date commentDate) {
        this.commentDate = commentDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Video getVideo() {
        return video;
    }

    public void setVideo(Video video) {
        this.video = video;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Comment{" + "commentId=" + commentId + ", content=" + content + ", commentDate=" + commentDate + ", user=" + user + ", video=" + video + ", status=" + status + '}';
    }
}
