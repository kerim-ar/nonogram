#ifndef NONOGRAMMODEL_H
#define NONOGRAMMODEL_H

#include <QAbstractListModel>

class NonogramModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString comment READ comment WRITE setComment NOTIFY commentChanged)

public:
    enum Roles { IsColored = Qt::UserRole + 1 };

    explicit NonogramModel(QObject *parent = 0);
    ~NonogramModel();

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    QString title() const;
    void setTitle(const QString &title);

    QString comment() const;
    void setComment(const QString &comment);

public slots:
    void init(const QString &title, int cellsAmount, const QString &comment);
    void toggleCell(int index);

signals:
    void titleChanged();
    void commentChanged();

private:
    QString m_title;
    QString m_comment;
    QVector<int> m_cells;
};

#endif // NONOGRAMMODEL_H
